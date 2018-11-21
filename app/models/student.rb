# frozen_string_literal: true

class Student < ApplicationRecord
  validates :cpf, presence: true, allow_blank: false, uniqueness: true
end
