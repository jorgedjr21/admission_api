# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :bill
  belongs_to :billing

  enum status: %i[waiting_payment paid late]
  enum payment_method: %i[bankslip credit_card]

  def self.save_from_bills_billing!(bills, billing)
    bills.each do |bill|
      payment_bankslip = Payment.new(value: bill.value, status: :waiting_payment, payment_method: :bankslip, expiry_date: bill.due_date, billing: billing, bill: bill)
      payment_cc = Payment.new(value: bill.value, status: :waiting_payment, payment_method: :credit_card, expiry_date: bill.due_date, billing: billing, bill: bill)
      payment_bankslip.save!
      payment_cc.save!
    end
  end
end
