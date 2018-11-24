# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Students', type: :request do
  let!(:students) { create_list(:student, 5) }

  describe 'GET /api/v1/students' do
    it 'must get all students' do
      get api_v1_students_path, params: {}
      expect(response.body).to eq(students.to_json)
    end
  end

  describe 'GET /api/v1/students/:id' do
    context 'when the student exists' do
      before { get api_v1_student_path(id: students.first.id) }

      it 'must return a student information' do
        expect(response.body).to eq(students.first.to_json)
      end

      it 'must have http status 200' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when the student doesn\' exists' do
      before { get api_v1_student_path(id: 999) }
      it 'must have http status 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /api/v1/students' do
    context 'when the request is valid' do
      before { post api_v1_students_path, params: { name: Faker::Name.name, cpf: CPF.generate(true) } }

      it 'must create a new student' do
        expect(response.body).to eq(Student.last.to_json)
      end

      it 'must have http status 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before { post api_v1_students_path, params: { name: Faker::Name.name, cpf: '' } }

      it 'must have http status 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/v1/students/:id' do
    context 'when the student exists' do
      before { put api_v1_student_path(id: students.first.id), params: { name: 'Updated Name' } }

      it 'must update the student' do
        expect(Student.first.name).to eq('Updated Name')
      end

      it 'must return empty response' do
        expect(response.body).to be_empty
      end

      it 'must have http status 204' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  describe 'DELETE /api/v1/students/:id' do
    context 'when the student exists' do
      before { delete api_v1_student_path(id: students.first.id) }

      it 'must return empty response' do
        expect(response.body).to be_empty
      end

      it 'must have http status 204' do
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
