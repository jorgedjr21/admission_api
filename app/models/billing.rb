# frozen_string_literal: true

class Billing < ApplicationRecord
  belongs_to :student
  has_many :bills

  validates :desired_due_day, :parcels_number, presence: true, allow_blank: false
end
