# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    value          { rand(100.00..999.99).round(2) }
    status         { :waiting_payment }
    payment_method { :bankslip }
    expiry_date    { Time.zone.now + 5.days }
    billing
    bill
  end
end
