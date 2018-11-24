# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Payments', type: :request do
  let!(:expiry_date)       { Time.zone.now + 5.days }
  let!(:value)             { rand(100..999.99).round(2) }
  let!(:student)           { create(:student, :with_billings) }
  let!(:bills_1)           { create_list(:bill, 5, billing: student.billings.first) }
  let!(:bills_2)           { create_list(:bill, 9, billing: student.billings.last) }
  let!(:payments_bankslip) { create_list(:payment, 2, value: value, expiry_date: expiry_date, billing: student.billings.first, bill: student.billings.first.bills.first) }
  let!(:payments_cc)       { create_list(:payment, 2, value: value, expiry_date: expiry_date, payment_method: :credit_card, billing: student.billings.first, bill: student.billings.first.bills.first) }

  describe 'GET /api/v1/students/:student_id/billings/:billing_id/bills/:bill_id/payments' do
    before { get api_v1_student_billing_bill_payments_path(student_id: student.id, billing_id: student.billings.first.id, bill_id: student.billings.first.bills.first.id) }
    it 'must return all payments' do
      expect(response.body).to eq(student.billings.first.bills.first.payments.to_json)
    end

    it 'must have status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/students/:student_id/billings/:billing_id/bills/:bill_id/payments/:id' do
    before { get api_v1_student_billing_bill_payment_path(id: student.billings.first.bills.first.payments.first.id, student_id: student.id, billing_id: student.billings.first.id, bill_id: student.billings.first.bills.first.id) }
    it 'must return a payment information' do
      expect(response.body).to eq(student.billings.first.bills.first.payments.first.to_json)
    end

    it 'must have status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
