# frozen_string_literal: true

module Api
  module V1
    class AdmissionsController < ApiApplicationController
      before_action :set_admission, only: %i[show edit update destroy]

      # GET students/:student_id/admissions
      def index
        json_response(Admission.where(student_id: admission_params[:student_id]))
      end

      # GET students/:student_id/admission/:id
      def show
        json_response(@admission)
      end

      # POST students/:student_id/admissions
      def create
        @admission = Admission.new(admission_params)
        @admission.save!
        json_response(@admission, :created)
      end

      # PATCH/PUT students/:student_id/admissions/:id
      def update
        @admission.update(admission_params)
        head :no_content
      end

      # DELETE students/:student_id/admissions/:id
      def destroy
        @admission.destroy
        head :no_content
      end

      private

      def admission_params
        params.permit(:id, :student_id, :enem_grade)
      end

      def set_admission
        @admission = Admission.find_by(id: admission_params[:id], student_id: admission_params[:student_id])
      end
    end
  end
end
