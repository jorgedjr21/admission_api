# frozen_string_literal: true

module Api
  module V1
    class PaymentsController < ApplicationController
      before_action :set_payment, only: %i[show]

      # GET /api/v1/students/:student_id/billings/:billing_id/bills/:bill_id/payments
      def index
        json_response(Payment.where(billing_id: payment_params[:billing_id], bill_id: payment_params[:bill_id]))
      end

      # /api/v1/students/:student_id/billings/:billing_id/bills/:bill_id/payments/:id
      def show
        json_response(@payment)
      end

      private

      def payment_params
        params.permit(:id, :billing_id, :bill_id)
      end

      def set_payment
        @payment = Payment.find_by(id: payment_params[:id], billing_id: payment_params[:billing_id], bill_id: payment_params[:bill_id])
      end
    end
  end
end
