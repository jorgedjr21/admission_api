# frozen_string_literal: true

class Admission < ApplicationRecord
  before_save      :admission_status
  belongs_to       :student
  has_one_attached :document

  enum status: %i[rejected approved]
  validates :enem_grade, presence: true, allow_blank: false
  validates :student_id, presence: true, allow_blank: false

  private

  def admission_status
    if enem_grade > 450
      self.status = :approved
    else
      self.status = :rejected
    end
  end
end
