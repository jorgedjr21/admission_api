# frozen_string_literal: true

module Api
  module V1
    class StudentsController < ApplicationController
      before_action :set_student, only: %i[show edit update destroy]

      # GET /students
      def index
        @students = Student.all
        json_response(@students)
      end

      # GET /students/:id
      def show
        json_response(@student)
      end

      # POST /students
      def create
        @student = Student.new(student_params)
        @student.save!
        json_response(@student, :created)
      end

      # PATCH/PUT /students/:id
      def update
        @student.update(student_params)
        head :no_content
      end

      # DELETE /students/:id
      def destroy
        @student.destroy
        head :no_content
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_student
        @student = Student.find(student_params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def student_params
        params.permit(:id, :name, :cpf)
      end
    end
  end
end
