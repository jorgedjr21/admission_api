# frozen_string_literal: true

FactoryBot.define do
  factory :bill do
    value     { rand(200..800) }
    due_date  { 15 }
    paid_date { 20 }
    status    { :paid }
    month     { rand(1..12) }
    year      { rand(2018..2030) }
    billing
  end
end
