class StudentsController < ApplicationController
    def create
      school = School.find_by(id: student_params[:school_id])
      classroom = Classroom.find_by(id: student_params[:classroom_id])
  
      if school.nil? || classroom.nil?
        return render json: { error: "School or classroom not found" }, status: :bad_request
      end
  
      student = Student.new(student_params)
      student.auth_token = SecureRandom.hex(32)
  
      if student.save
        response.set_header("X-Auth-Token", student.auth_token)
  
        render json: student, status: :created
      else
        render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def index
      students = Student.where(
        school_id: params[:school_id],
        classroom_id: params[:class_id]
      )
  
      render json: {
        data: students
      }
    end
  
    def destroy
      student = Student.find_by(id: params[:user_id])
  
      return head :bad_request if student.nil?
  
      token = request.headers["Authorization"]&.split(" ")&.last
  
      if token != student.auth_token
        return head :unauthorized
      end
  
      student.destroy
  
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