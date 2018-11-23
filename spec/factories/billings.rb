# frozen_string_literal: true

FactoryBot.define do
  factory :billing do
    desired_due_day { rand(1..30) }
    parcels_number  { rand(1..12) }
    student
  end
end
