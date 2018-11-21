# frozen_string_literal: true

class Admission < ApplicationRecord
  belongs_to :student
  has_one_attached :document
end
