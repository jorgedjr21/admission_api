# frozen_string_literal: true

class Billing < ApplicationRecord
  before_create :billing_status
  belongs_to    :student
  has_many      :bills

  enum status: %i[in_day late]
  validates :desired_due_day, :parcels_number, presence: true, allow_blank: false
  validates :parcels_number,  numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :desired_due_day, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 31 }

  private

  def billing_status
    self.status = :in_day
  end
end
