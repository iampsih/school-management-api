module Students
    class DeleteService
      Result = Struct.new(:success?, :status, keyword_init: true)
  
      def initialize(user_id:, token:)
        @user_id = user_id
        @token = token
      end
  
      def call
        student = Student.find_by(id: @user_id)
  
        return Result.new(success?: false, status: :bad_request) if student.nil?
        return Result.new(success?: false, status: :unauthorized) if @token != student.auth_token
  
        student.destroy
  
        Result.new(success?: true, status: :ok)
      end
    end
  end