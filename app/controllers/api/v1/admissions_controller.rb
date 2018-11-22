# frozen_string_literal: true

module Api
  module V1
    class AdmissionsController < ApplicationController
      before_action :set_admission, only: %i[show edit update destroy]

      # GET /admissions
      def index
        json_response(Admission.all)
      end

      # GET /admission/:id
      def show
        json_response(@admission)
      end

      # POST /admissions
      def create
        @admission = Admission.new(admission_params)
        @admission.save!
        json_response(@admission, :created)
      end

      # PATCH/PUT /admission/1
      def update
        @admission.update(admission_params)
        head :no_content
      end

      # DELETE /admission/:id
      def destroy
        @admission.destroy
        head :no_content
      end

      private

      def admission_params
        params.permit(:student_id, :enem_grade)
      end

      def set_admission
        @admission = Admission.find_by(id: params[:id], student_id: params[:student_id])
      end
    end
  end
end
