require "rails_helper"

describe User do
  describe 'associations' do
    it { should have_one(:patient).class_name('Patient') }
    it { should have_one(:doctor).class_name('Doctor') }
  end
end
