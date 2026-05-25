require "test_helper"

class ClassesControllerTest < ActionDispatch::IntegrationTest
  test "returns school classes" do
    school = School.create!(name: "School #1")
    classroom = Classroom.create!(number: 5, letter: "A", school: school)

    Student.create!(
      first_name: "Merey",
      last_name: "Bolat",
      surname: "Test",
      school: school,
      classroom: classroom,
      auth_token: SecureRandom.hex(32)
    )

    get "/schools/#{school.id}/classes"

    assert_response :ok

    body = JSON.parse(response.body)

    assert_equal 1, body["data"].size
    assert_equal 5, body["data"][0]["number"]
    assert_equal "A", body["data"][0]["letter"]
    assert_equal 1, body["data"][0]["students_count"]
  end
end