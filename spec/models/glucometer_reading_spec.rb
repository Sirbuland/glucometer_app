require "rails_helper"

describe GlucometerReading do
  describe 'associations' do
    it { should belong_to(:patient).class_name('Patient') }
  end

  describe 'validations' do
    it { should validate_presence_of(:reading) }
  end
end
