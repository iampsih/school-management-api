class ClassesController < ApplicationController
  def index
    classrooms = Classroom.where(school_id: params[:school_id])

    render json: {
      data: classrooms.map { |classroom| ClassroomSerializer.call(classroom) }
    }
  end
end