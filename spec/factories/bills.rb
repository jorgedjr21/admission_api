# frozen_string_literal: true

FactoryBot.define do
  factory :bill do
    value     { rand(100..999.99).round(2) }
    due_date  { Time.zone.now + 10.days }
    paid_date { nil }
    status    { :paid }
    month     { rand(1..12) }
    year      { rand(2018..2030) }
    billing
  end
end
