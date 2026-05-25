Rails.application.routes.draw do
  post "/students", to: "students#create"
  delete "/students/:user_id", to: "students#destroy"

  get "/schools/:school_id/classes", to: "classes#index"

  get "/schools/:school_id/classes/:class_id/students",
      to: "students#index"

  get "/api-docs",
      to: proc { [302, { "Location" => "/swagger.html" }, []] }
end