# frozen_string_literal: true

class Student < ApplicationRecord
  has_many :admissions
  has_many :billings

  validates :cpf, presence: true, allow_blank: false, uniqueness: true
  validate  :valid_cpf

  def as_json(_options = {})
    super(only: %i[id name cpf created_at updated_at],
          include: { billings: { only: %i[id desired_due_day status student_id parcels_number created_at updated_at] } }
         )
  end

  def valid_cpf
    errors.add(':cpf', 'it\'s not a valid CPF') unless CPF.valid?(cpf)
  end
end
