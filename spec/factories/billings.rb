# frozen_string_literal: true

FactoryBot.define do
  factory :billing do
    desired_due_day { rand(1..30) }
    parcels_number  { rand(1..12) }
    student

    trait :with_bills do
      transient do
        bills_count { 6 }
      end

      after(:create) do |billing, evaluator|
        create_list(:bill, evaluator.bills_count, billing: billing)
      end
    end
  end
end
