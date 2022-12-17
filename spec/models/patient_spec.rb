require "rails_helper"

describe Patient do
  describe 'associations' do
    it { should have_many(:glucometer_readings).class_name('GlucometerReading') }
    it { should have_many(:doctor_patients).class_name('DoctorPatient') }
    it { should have_many(:doctors).class_name('Doctor') }
  end
end
