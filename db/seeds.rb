school = School.create!(
  name: "School #1"
)

classroom = Classroom.create!(
  number: 5,
  letter: "A",
  school: school
)

puts "Seed data created"
puts "School ID: #{school.id}"
puts "Classroom ID: #{classroom.id}"