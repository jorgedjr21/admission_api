# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payment, type: :model do
  let!(:billing) { create(:billing) }
  let!(:bills)   { create_list(:bill, 5, billing: billing) }

  describe '#save_from_bills_billing!' do
    it 'must create the payments for bill' do
      expect{ Payment.save_from_bills_billing!(billing.bills, billing) }.to change(Payment, :count).by(10)
    end
  end

end
