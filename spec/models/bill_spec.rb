# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bill, type: :model do
  let!(:billing) { create(:billing) }

  describe 'as_json' do
    let!(:bill) { create(:bill) }

    it 'must return the correct json' do

      json = {
        "id": bill.id,
        "value": bill.value.to_s,
        "due_date": bill.due_date.strftime('%Y-%m-%dT%H:%M:%S.%L%:z'),
        "status": bill.status.to_s,
        "month": bill.month,
        "year": bill.year,
        "created_at": bill.created_at.strftime('%Y-%m-%dT%H:%M:%S.%L%:z'),
        "updated_at": bill.updated_at.strftime('%Y-%m-%dT%H:%M:%S.%L%:z'),
        "payments": []
      }

      expect(bill.to_json).to include_json(json)
    end
  end


  describe '#calculate_bill_month' do
    context 'when today is bigger than desired_due_day' do
      it 'must return the bill_month with one month plus' do
        expect(Bill.calculate_start_bill_month('15', '08')).to eq(9)
      end
    end
    context 'when desired_due_day is bigger than today' do
      it 'must return the actual month as bill_month' do
        expect(Bill.calculate_start_bill_month('30', '08')).to eq(8)
      end
    end
  end

  describe '#format_bill_date' do
    it 'must return a formatted date as Time' do
      expect(Bill.format_bill_date('15', '06')).to eq(Time.zone.parse('15/06/2018'))
    end
  end

  describe 'get_payment_date' do
    it 'must return the payment date plus the parcels month' do
      expect(Bill.get_payment_date(Time.zone.now, 3).strftime('%d/%m/%Y')).to eq((Time.zone.now + 3.month).strftime('%d/%m/%Y'))
    end
  end
  describe '#save_from_billing!' do
    it 'must create the bill with the desired_due_day, parcels_number and value' do
      expect { Bill.save_from_billing!(billing, 15, 3, 725.25) }.to change(Bill, :count).by(3)
    end

    it 'must raise ActiveRecord::RecordInvalid if can\'t save the bill' do
      expect { Bill.save_from_billing!(billing, 15, 3, 0.00) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
