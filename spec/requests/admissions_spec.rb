# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admissions', type: :request do
  let!(:student)   { create(:student, :with_admissions) }
  let!(:student_2) { create(:student, :with_admissions) }

  describe 'GET /api/v1/students/:student_id/admissions' do
    it 'must return all admissions from student' do
      get api_v1_student_admissions_path(student_id: student.id)
      expect(response.body).to eq(student.admissions.to_json)
    end

    it 'must have status code 200' do
      get api_v1_student_admissions_path(student_id: student.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/students/:student_id/admissions/:id' do
    before { get api_v1_student_admission_path(student_id: student.id, id: student.admissions.first.id) }

    it 'must show a admission information' do
      expect(response.body).to eq(student.admissions.first.to_json)
    end

    it 'must have http status 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/v1/students/:student_id/admissions' do
    context 'when the request is valid' do
      before { post api_v1_student_admissions_path(student_id: student.id), params: { enem_grade: 850 } }

      it 'must create a new admission' do
        expect(response.body).to eq(Admission.last.to_json)
      end

      it 'must have http status 201' do
        expect(response).to have_http_status(:created)
      end

      context 'when enem_grade > 450' do
        it 'must have the new admission with status approved' do
          expect(Admission.last.status).to eq('approved')
        end
      end

      context 'when enem_grade <= 450' do
        before { post api_v1_student_admissions_path(student_id: student.id), params: { enem_grade: 449 } }

        it 'must have the new admission with status rejected' do
          expect(Admission.last.status).to eq('rejected')
        end
      end
    end

    context 'when the request is invalid' do
      before { post api_v1_student_admissions_path(student_id: student.id), params: { enem_grade: '' } }

      it 'must have http status 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/v1/students/:student_id/admissions/:id' do
    context 'when the admission exists' do
      before { put api_v1_student_admission_path(student_id: student.id, id: student.admissions.first.id), params: { enem_grade: 999 } }

      it 'must update the admission' do
        expect(Admission.first.enem_grade).to eq(999)
      end

      it 'must return empty response' do
        expect(response.body).to be_empty
      end

      it 'must have http status 204' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'DELETE /api/v1/students/:student_id/admissions/:id' do
    context 'when the student exists' do
      before { delete api_v1_student_admission_path(student_id: student.id, id: student.admissions.first.id) }

      it 'must return empty response' do
        expect(response.body).to be_empty
      end

      it 'must have http status 204' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
