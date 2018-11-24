# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Billings', type: :request do
  let!(:student) { create(:student, :with_billings) }

  describe 'GET students/:student_id/billings' do
    before { get api_v1_student_billings_path(student_id: student.id) }
    it 'must return all billings' do
      expect(response.body).to eq(student.billings.to_json)
    end

    it 'must have status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET students/:student_id/billings/:id' do
    before { get api_v1_student_billing_path(id: student.billings.first, student_id: student.id) }
    it 'must return a billing information' do
      expect(response.body).to eq(student.billings.first.to_json)
    end

    it 'must have status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST students/:student_id/billings' do
    context 'when the request is valid' do
      before { post api_v1_student_billings_path(student_id: student.id), params: { desired_due_day: 15, parcels_number: 3, value: 759.90 } }

      it 'must create a new billing' do
        expect(response.body).to eq(Billing.last.to_json)
      end

      it 'must have in_day status' do
        expect(Billing.last.status).to eq('in_day')
      end

      it 'must have http status 201' do
        expect(response).to have_http_status(:created)
      end

      it 'must create the bills from billing' do
        expect(Bill.count).to eq(3)
      end

      it 'must create the payments for the bills billing' do
        expect(Payment.count).to eq(6)
      end
    end

    context 'when the request for billing is invalid' do
      before { post api_v1_student_billings_path(student_id: student.id), params: { desired_due_day: '', parcels_number: 0, value: 759.90 } }

      it 'must have http status 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'must not create the billing' do
        expect{ post api_v1_student_billings_path(student_id: student.id), params: { desired_due_day: '', parcels_number: 0, value: 759.90 } }.not_to change(Billing, :count)
      end

      it 'must not create the bills' do
        expect{ post api_v1_student_billings_path(student_id: student.id), params: { desired_due_day: '', parcels_number: 0, value: 759.90 } }.not_to change(Bill, :count)
      end

      it 'must not create the payments for the bills billing' do
        expect{ post api_v1_student_billings_path(student_id: student.id), params: { desired_due_day: '', parcels_number: 0, value: 759.90 } }.not_to change(Payment, :count)
      end
    end

    context 'when the request for billing is valid but for bill is invalid' do
      it 'must have http status 422' do
        post api_v1_student_billings_path(student_id: student.id), params: { desired_due_day: 15, parcels_number: 3, value: 0.00 }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'must not create the billing' do
        expect { post api_v1_student_billings_path(student_id: student.id), params: { desired_due_day: 15, parcels_number: 3, value: 0.00 } }.not_to change(Billing, :count)
      end

      it 'must not create the bills' do
        expect { post api_v1_student_billings_path(student_id: student.id), params: { desired_due_day: 15, parcels_number: 3, value: 0.00 } }.not_to change(Bill, :count)
      end

      it 'must not create the payments for the bills billing' do
        expect { post api_v1_student_billings_path(student_id: student.id), params: { desired_due_day: '', parcels_number: 0, value: 759.90 } }.not_to change(Payment, :count)
      end
    end
  end

  describe 'PUT /update' do
    context 'when the billing exists' do
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
    context 'when the billing exists' do
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
