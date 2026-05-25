class ClassesController < ApplicationController
    def index
      classrooms = Classroom.where(
        school_id: params[:school_id]
      )
  
      data = classrooms.map do |classroom|
        {
          id: classroom.id,
          number: classroom.number,
          letter: classroom.letter,
          students_count: classroom.students.count
        }
      end
  
      render json: {
        data: data
      }
    end
end