class Api::V1::StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  def index
    @students = Student.all
    json_response(@students)
  end

  # GET /students/1
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  def create
    @student = Student.new(student_params)
    @student.save
    json_response(@student, :created)
  end

  # PATCH/PUT /students/1
  def update
    @student.update(student_params)
    head :no_content
  end

  # DELETE /students/1
  def destroy
    @student.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def student_params
      params.require(:student).permit(:name, :cpf)
    end
end
