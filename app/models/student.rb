# frozen_string_literal: true

class Student < ApplicationRecord
  has_many :admissions
  has_many :billings

  validates :cpf, presence: true, allow_blank: false, uniqueness: true
  validate  :valid_cpf

  def valid_cpf
    errors.add(':cpf', 'it\'s not a valid CPF') unless CPF.valid?(cpf)
  end
end
