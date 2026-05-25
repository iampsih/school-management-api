module Students
    class CreateService
      Result = Struct.new(:success?, :student, :error, keyword_init: true)
  
      def initialize(params)
        @params = params
      end
  
      def call
        school = School.find_by(id: @params[:school_id])
        classroom = Classroom.find_by(id: @params[:classroom_id])
      
        return Result.new(success?: false, error: "School not found") if school.nil?
        return Result.new(success?: false, error: "Classroom not found") if classroom.nil?
        return Result.new(success?: false, error: "Classroom does not belong to school") if classroom.school_id != school.id
      
        student = Student.new(@params)
        student.auth_token = SecureRandom.hex(32)
      
        if student.save
          Result.new(success?: true, student: student)
        else
          Result.new(success?: false, error: student.errors.full_messages)
        end
      end
    end
  end