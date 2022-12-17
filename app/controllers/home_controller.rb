class HomeController < ApplicationController
  def dashboard
    @records = GlucometerReading.where(created_at: 5.days.ago..DateTime.now).order(:created_at)
  end
end
