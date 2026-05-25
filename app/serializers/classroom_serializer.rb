class ClassroomSerializer
    def self.call(classroom)
      {
        id: classroom.id,
        number: classroom.number,
        letter: classroom.letter,
        students_count: classroom.students.count
      }
    end
end