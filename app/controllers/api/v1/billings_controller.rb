# frozen_string_literal: true

module Api
  module V1
    class BillingsController < ApiApplicationController
      before_action :set_billing, only: %i[show edit update destroy]

      # GET students/:student_id/billings
      def index
        json_response(Billing.where(student_id: billing_params[:student_id]))
      end

      # GET students/:student_id/billings/:id
      def show
        json_response(@billing)
      end

      # POST students/:student_id/billings
      def create
        @billing = Billing.new(billing_params)
        ActiveRecord::Base.transaction do
          begin
            @billing.save!
            Bill.save_from_billing!(@billing, @billing.desired_due_day, @billing.parcels_number, bill_params[:value])
            Payment.save_from_bills_billing!(@billing.bills, @billing)
          rescue ActiveRecord::Errors
            ActiveRecord::Rollback
          end
        end
        json_response(@billing, :created)
      end

      # PATCH/PUT students/:student_id/billings/:id
      def update
        if @billing.bills.present?
          json_response('Can\'t update billing because it already have bills', :forbidden)
        else
          @billing.update(billing_params)
          head :no_content
        end
      end

      # DELETE students/:student_id/billings/:id
      def destroy
        if @billing.bills.present?
          json_response('Can\'t update billing because it already have bills', :forbidden)
        else
          @billing.destroy
          head :no_content
        end
      end

      private

      def billing_params
        params.permit(:id, :student_id, :desired_due_day, :parcels_number)
      end

      def bill_params
        params.permit(:value)
      end

      def set_billing
        @billing = Billing.find_by(id: billing_params[:id], student_id: billing_params[:student_id])
      end
    end
  end
end
