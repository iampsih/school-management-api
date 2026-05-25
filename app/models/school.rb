class School < ApplicationRecord
    has_many :classrooms, dependent: :destroy
    has_many :students, dependent: :destroy
  
    validates :name, presence: true
  end