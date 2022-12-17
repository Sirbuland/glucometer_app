class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  enum role: [:patient, :doctor]
  has_one :patient
  has_one :doctor

  after_initialize :initialize_associated_role

  private

  def initialize_associated_role
    if self.patient? && patient.blank?
      self.patient = Patient.new
    elsif self.doctor? && doctor.blank?
      self.doctor = Doctor.new
    end
  end
end
