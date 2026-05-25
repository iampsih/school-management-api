class StudentsController < ApplicationController
  def create
    result = Students::CreateService.new(student_params).call

    if result.success?
      response.set_header("X-Auth-Token", result.student.auth_token)
      render json: StudentSerializer.call(result.student), status: :created
    else
      render json: { error: result.error }, status: :bad_request
    end
  end

  def index
    students = Student.where(
      school_id: params[:school_id],
      classroom_id: params[:class_id]
    )

    render json: { 
      data: students.map { |student| StudentSerializer.call(student) } 
    }
  end

  def destroy
    token = request.headers["Authorization"]&.split(" ")&.last

    result = Students::DeleteService.new(
      user_id: params[:user_id],
      token: token
    ).call

    return head result.status unless result.success?

    head :ok
  end

  private

  def student_params
    params.require(:student).permit(
      :first_name,
      :last_name,
      :surname,
      :school_id,
      :classroom_id
    )
  end
end