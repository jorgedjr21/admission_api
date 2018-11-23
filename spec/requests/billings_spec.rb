# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Students', type: :request do
  let!(:student) { create(:student, :with_billings) }

  describe 'GET students/:student_id/billings' do
    it 'must return all billings' do
      get api_v1_student_billings_path(student_id: student.id)
      expect(response.body).to eq(student.billings.to_json)
    end

    it 'must have status code 200' do
      get api_v1_student_billings_path(student_id: student.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST students/:student_id/billings' do
    context 'when the request is valid' do
      before { post api_v1_student_billings_path(student_id: student.id), params: { desired_due_day: 15, parcels_number: 3 } }

      it 'must create a new admission' do
        expect(response.body).to eq(Billing.last.to_json)
      end

      it 'must have http status 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before { post api_v1_student_billings_path(student_id: student.id), params: { desired_due_day: '', parcels_number: 0 } }

      it 'must have http status 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /update' do
    context 'when the admission exists' do
      before { put api_v1_student_billing_path(student_id: student.id, id: student.billings.first.id), params: { desired_due_day: '19', parcels_number: 10 } }

      it 'must update the billing due date' do
        expect(Billing.first.desired_due_day).to eq(19)
      end
      it 'must update the billing parcels number' do
        expect(Billing.first.parcels_number).to eq(10)
      end

      it 'must return empty response' do
        expect(response.body).to be_empty
      end

      it 'must have http status 204' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'when the student exists' do
      before { delete api_v1_student_billing_path(student_id: student.id, id: student.billings.first.id) }

      it 'must return empty response' do
        expect(response.body).to be_empty
      end

      it 'must have http status 204' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
