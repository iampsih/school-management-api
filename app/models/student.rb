class Student < ApplicationRecord
  belongs_to :school
  belongs_to :classroom

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :surname, presence: true
  validates :auth_token, presence: true, uniqueness: true
end