require "test_helper"

class StudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @school = School.create!(name: "School #1")
    @classroom = Classroom.create!(number: 5, letter: "A", school: @school)
  end

  test "creates student" do
    post "/students",
      params: {
        student: {
          first_name: "Merey",
          last_name: "Bolat",
          surname: "Test",
          school_id: @school.id,
          classroom_id: @classroom.id
        }
      },
      as: :json

    assert_response :created
    assert response.headers["X-Auth-Token"].present?

    body = JSON.parse(response.body)

    assert_equal "Merey", body["first_name"]
    assert_nil body["auth_token"]
  end

  test "does not create student with unknown classroom" do
    post "/students",
      params: {
        student: {
          first_name: "Merey",
          last_name: "Bolat",
          surname: "Test",
          school_id: @school.id,
          classroom_id: 999
        }
      },
      as: :json

    assert_response :bad_request

    body = JSON.parse(response.body)
    assert_equal "Classroom not found", body["error"]
  end

  test "deletes student with valid token" do
    student = Student.create!(
      first_name: "Merey",
      last_name: "Bolat",
      surname: "Test",
      school: @school,
      classroom: @classroom,
      auth_token: SecureRandom.hex(32)
    )

    delete "/students/#{student.id}",
      headers: {
        "Authorization" => "Bearer #{student.auth_token}"
      }

    assert_response :ok
    assert_nil Student.find_by(id: student.id)
  end

  test "does not delete student with invalid token" do
    student = Student.create!(
      first_name: "Merey",
      last_name: "Bolat",
      surname: "Test",
      school: @school,
      classroom: @classroom,
      auth_token: SecureRandom.hex(32)
    )

    delete "/students/#{student.id}",
      headers: {
        "Authorization" => "Bearer wrong-token"
      }

    assert_response :unauthorized
  end
end