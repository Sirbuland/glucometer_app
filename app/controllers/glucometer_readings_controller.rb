class GlucometerReadingsController < ApplicationController
  before_action :set_patient
  skip_before_action :verify_authenticity_token, only: [:index]

  def index
    @report_data = ReportGenerator.call(@patient.id, params[:report_type], params[:end_date])

    respond_to do |format|
      format.html
      format.csv { send_data @report_data, filename: "#{params[:report_type]}-report.csv" }
    end
  end

  def create
    @glucometer_reading = @patient.glucometer_readings.new(glucometer_reading_params)
    if @glucometer_reading.save
      flash[:notice] = "Reading saved successfully"
      redirect_back fallback_location: root_path
    else
      flash[:alert] = @glucometer_reading.errors.full_messages.to_sentence
      redirect_back fallback_location: root_path
    end
  end

  private

  def set_patient
    @patient = Patient.find_by_id(params[:patient_id])
    redirect_to :root_path, notice: "You are not Authorised" if @patient.blank?
  end

  def glucometer_reading_params
    params.require(:glucometer_reading).permit(:reading)
  end
end
