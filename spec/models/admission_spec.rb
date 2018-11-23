# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admission, type: :model do
  let!(:admission) { build(:admission) }

  describe 'When saving an admission' do
    before { admission.save }
    it 'must set the admission status' do
      expect(admission.status).not_to be_empty
    end
  end
end
