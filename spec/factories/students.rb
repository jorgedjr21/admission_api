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
        billings_count { 5 }
      end

      after(:create) do |student, evaluator|
        create_list(:billing, evaluator.billings_count, student: student)
      end
    end
  end
end
