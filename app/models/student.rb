class Student < ApplicationRecord
  validates :cpf, presence: true, uniqueness: true
end
