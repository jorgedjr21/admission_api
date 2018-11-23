# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Billing, type: :model do

  describe 'When saving a billing' do
    let!(:billing) { build(:billing)}

    context 'checking the desired_due_day' do
      before { billing.desired_due_day = 40 }
      it 'must be invalid desired_due_day if desired_due_day < 1 and > 31' do
        expect(billing.valid?).to be_falsey
      end

      it 'raises an desired_due_day error' do
        billing.validate
        expect(billing.errors.full_messages).to include('Desired due day must be less than or equal to 31')
      end
    end

    context 'checking the parcels_number' do
      before { billing.parcels_number = 19 }
      it 'must be invalid parcels_number if parcels_number < 1 and > 12' do
        expect(billing.valid?).to be_falsey
      end

      it 'raises an desired_due_day error' do
        billing.validate
        expect(billing.errors.full_messages).to include('Parcels number must be less than or equal to 12')
      end
    end
  end
end
