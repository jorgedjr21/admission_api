# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Billing, type: :model do

  describe 'as_json' do
    let!(:billing_1) { create(:billing) }

    it 'must return the correct json' do

      json = {
        "id": billing_1.id,
        "desired_due_day": billing_1.desired_due_day,
        "status": billing_1.status.to_s,
        "created_at": billing_1.created_at.strftime('%Y-%m-%dT%H:%M:%S.%L%:z'),
        "updated_at": billing_1.updated_at.strftime('%Y-%m-%dT%H:%M:%S.%L%:z'),
        "student_id": billing_1.student_id,
        "parcels_number": billing_1.parcels_number,
        "bills": []
      }

      expect(billing_1.to_json).to include_json(json)
    end
  end

  describe 'When saving a billing' do
    let!(:billing_2) { build(:billing)}

    context 'checking the desired_due_day' do
      before { billing_2.desired_due_day = 40 }
      it 'must be invalid desired_due_day if desired_due_day < 1 and > 31' do
        expect(billing_2.valid?).to be_falsey
      end

      it 'raises an desired_due_day error' do
        billing_2.validate
        expect(billing_2.errors.full_messages).to include('Desired due day must be less than or equal to 31')
      end
    end

    context 'checking the parcels_number' do
      before { billing_2.parcels_number = 19 }
      it 'must be invalid parcels_number if parcels_number < 1 and > 12' do
        expect(billing_2.valid?).to be_falsey
      end

      it 'raises an desired_due_day error' do
        billing_2.validate
        expect(billing_2.errors.full_messages).to include('Parcels number must be less than or equal to 12')
      end
    end
  end
end
