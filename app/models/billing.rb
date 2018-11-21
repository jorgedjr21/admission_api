class Billing < ApplicationRecord
  belongs_to :student

  validates :desired_due_day, presence: true
end
