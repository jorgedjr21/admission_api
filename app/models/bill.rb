# frozen_string_literal: true

class Bill < ApplicationRecord
  has_many :payments

  validates :year, :month,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
end
