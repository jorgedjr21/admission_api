# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  let!(:student) { build(:student) }
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
