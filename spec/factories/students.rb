# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    name { Faker::Name.name }
    cpf  { CPF.generate(true) }

    trait :with_admissions do
      transient do
        admissions_count { 10 }
      end

      after(:create) do |student, evaluator|
        create_list(:admission, evaluator.admissions_count, student: student)
      end
    end

    trait :with_billings do
      transient do
        billings_count  { 5 }
        desired_due_day { nil }
        parcels_number  { nil }
      end

      after(:create) do |student, evaluator|
        if evaluator.desired_due_day.present? && evaluator.parcels_number.present?
          create_list(:billing, evaluator.billings_count, student: student, desired_due_day: evaluator.desired_due_day, parcels_number: evaluator.parcels_number)
        else
          create_list(:billing, evaluator.billings_count, student: student)
        end
      end
    end
  end
end
