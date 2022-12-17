require "rails_helper"

describe GlucometerReadingsController do
  include Devise::Test::ControllerHelpers

  let!(:user) { FactoryGirl.create(:user) }

  describe "POST #create" do
    before do
      sign_in user
      params = {
        patient_id: user.patient.id,
        glucometer_reading: { reading: 100 }
      }
      post :create, params: params
    end

    it "creats reading" do
      expect(assigns(@glucometer_reading).present?).to eq(true)
      expect(response.status).to eq(302)
    end

    it "assigns patient" do
      expect(assigns(@patient).present?).to eq(true)
    end
  end
end
