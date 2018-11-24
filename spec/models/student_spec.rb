# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  let!(:student) { build(:student) }
  describe 'as_json' do
    let!(:student_2) { create(:student) }

    it 'must return the correct json' do

      json = {
        "id": student_2.id,
        "name": student_2.name,
        "cpf": student_2.cpf,
        "created_at": student_2.created_at.strftime('%Y-%m-%dT%H:%M:%S.%L%:z'),
        "updated_at": student_2.updated_at.strftime('%Y-%m-%dT%H:%M:%S.%L%:z'),
        "billings": []
      }

      expect(student_2.to_json).to include_json(json)
    end
  end

  describe 'valid CPF Validation' do
    context 'when CPF is invalid' do
      before { student.cpf = '111.222.333-76' }

      it 'student must be invalid' do
        expect(student.valid?).to be_falsey
      end

      it 'raises an cpf error' do
        student.validate
        expect(student.errors.full_messages).to include(':cpf it\'s not a valid CPF')
      end
    end
  end
end
