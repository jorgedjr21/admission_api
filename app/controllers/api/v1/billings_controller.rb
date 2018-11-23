# frozen_string_literal: true

module Api
  module V1
    class BillingsController < ApplicationController
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
        @billing.save!
        json_response(@billing, :created)
      end

      # PATCH/PUT students/:student_id/billings/:id
      def update
        @billing.update(billing_params)
        head :no_content
      end

      # DELETE students/:student_id/billings/:id
      def destroy
        @billing.destroy
        head :no_content
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
