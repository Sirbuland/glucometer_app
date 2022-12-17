class Patient < ApplicationRecord
  belongs_to :user

  has_many :glucometer_readings
  has_many :doctor_patients
  has_many :doctors, through: :doctor_patients
end
