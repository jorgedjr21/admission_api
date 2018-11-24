# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Bills', type: :request do
  let!(:student) { create(:student, :with_billings) }
  let!(:bills_1)   { create_list(:bill, 5, billing: student.billings.first) }
  let!(:bills_2)   { create_list(:bill, 9, billing: student.billings.last) }

  describe 'GET /api/v1/students/:student_id/billings/:billing_id/bills' do
    before { get api_v1_student_billing_bills_path(student_id: student.id, billing_id: student.billings.first.id) }
    it 'must return all billings' do
      expect(response.body).to eq(student.billings.first.bills.to_json)
    end

    it 'must have status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/students/:student_id/billings/:billing_id/bills/:id' do
    before { get api_v1_student_billing_bill_path(id: student.billings.last.bills.first.id, student_id: student.id, billing_id: student.billings.last.id) }

    it 'must return the bill information' do
      expect(response.body).to eq(student.billings.last.bills.first.to_json)
    end

    it 'must have status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
