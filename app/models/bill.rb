# frozen_string_literal: true

class Bill < ApplicationRecord
  has_many   :payments
  belongs_to :billing

  validates  :year, :month,
             presence: true,
             numericality: { only_integer: true, greater_than: 0 }

  validates :value, presence: true, numericality: { greater_than: 0 }
  enum      status: %i[waiting paid]

  def as_json(_options = {})
    super(only: %i[id value due_date status month year created_at updated_at],
          include: { payments: { only: %i[id value status payment_method created_at updated_at] } }
         )
  end

  def self.save_from_billing!(billing, desired_due_day, parcels_number, value)
    raise ActiveRecord::RecordInvalid if parcels_number.zero? || desired_due_day.zero?

    month = calculate_start_bill_month(desired_due_day, Time.zone.now.strftime('%m'))
    payment_start = format_bill_date(desired_due_day, month)
    parcels_number.times do |i|
      payment_date = get_payment_date(payment_start, i)
      bill = Bill.new(value: value,
                      due_date: payment_date,
                      month: payment_date.strftime('%m'),
                      year:  payment_date.strftime('%Y'),
                      status: :waiting,
                      billing: billing)
      raise ActiveRecord::RecordInvalid unless bill.save
    end
  end

  def self.calculate_start_bill_month(desired_due_day, month)
    date = format_bill_date(desired_due_day, month)
    return (date + 1.month).strftime('%m').to_i if Time.zone.now.strftime('%d').to_i > desired_due_day.to_i

    date.strftime('%m').to_i
  end

  def self.get_payment_date(payment_date, parcel)
    return payment_date if parcel.zero?

    payment_date + parcel.month
  end

  def self.format_bill_date(desired_due_day, month)
    Time.zone.parse("#{desired_due_day.to_i}/#{month.to_i}/#{Time.zone.now.strftime('%Y').to_i}")
  end
end
