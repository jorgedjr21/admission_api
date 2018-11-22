# frozen_string_literal: true

FactoryBot.define do
  factory :admission do
    enem_grade { rand(0..1000) }
    student

  end
end
