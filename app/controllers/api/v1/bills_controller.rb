# frozen_string_literal: true

module Api
  module V1
    class BillsController < ApplicationController
      before_action :set_billing, only: %i[show edit update destroy]

      # GET /api/v1/students/:student_id/billings/:billing_id/bills
      def index
        json_response(Bill.where(billing_id: bill_params[:billing_id]))
      end

      # GET /api/v1/students/:student_id/billings/:billing_id/bills/:id
      def show
        json_response(@bill)
      end

      private

      def bill_params
        params.permit(:id, :billing_id)
      end

      def set_bill
        @bill = Bill.find_by(id: billing_params[:id], billing_id: bill_params[:billing_id])
      end
    end
  end
end
