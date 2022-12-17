# app/services/report_generator.rb
require 'csv'

class ReportGenerator < ApplicationService
  HEADER = ["Date", "Maximum Reading", "Minimum Reading", "Average"]

  def initialize(patient_id, report_type, end_date = nil)
    @patient = Patient.find_by_id(patient_id)
    @report_type = report_type
    @end_date = end_date
  end

  def call
    send "#{@report_type}_report_data"
  end

  def daily_report_data
    @records = @patient.glucometer_readings
    @records = @patient.glucometer_readings.where("created_at <= ?", DateTime.strptime(@end_date, "%m/%d/%Y").end_of_day) if @end_date.present?

    fetch_dates

    CSV.generate(headers: true) do |csv|
      csv << HEADER

      while @start_day <= @end_day do
        daily_records = @records.where(created_at: @start_day.beginning_of_day..@start_day.end_of_day)
        readings = daily_records.pluck(:reading)
        csv << [@start_day.strftime("%d/%m/%Y"), readings.max, readings.min, average(readings)] if readings.present?

        @start_day += 1.day
      end
    end
  end

  def month_to_date_report_data

    # From start of current month to today if no end_day is present
    @records = @patient.glucometer_readings.where(created_at: Date.today.beginning_of_month..Date.today.end_of_day)
    end_date =  DateTime.strptime(@end_date, "%m/%d/%Y") if @end_date.present?

    @records = @patient.glucometer_readings.where(created_at: end_date.beginning_of_month..end_date.end_of_day) if @end_date.present?

    fetch_dates

    CSV.generate(headers: true) do |csv|
      csv << HEADER

      while @start_day <= @end_day do
        daily_records = @records.where(created_at: @start_day.beginning_of_day..@start_day.end_of_day)
        readings = daily_records.pluck(:reading)
        csv << [@start_day.strftime("%d/%m/%Y"), readings.max, readings.min, average(readings)]

        @start_day += 1.day
      end
    end
  end

  def monthly_report_data
    @records = @patient.glucometer_readings
    @records = @patient.glucometer_readings.where("created_at <= ?", DateTime.strptime(@end_date, "%m/%d/%Y").end_of_month) if @end_date.present?

    @start_day = Date.today
    @end_day = 1.day.ago

    if @records.present?
      @start_day = @records.order(:created_at).first.created_at.beginning_of_month.to_date
      @end_day = @records.order(:created_at).last.created_at.end_of_month.to_date
    end

    CSV.generate(headers: true) do |csv|
      csv << HEADER

      while @start_day <= @end_day do
        monthly_records = @records.where(created_at: @start_day.beginning_of_month..@start_day.end_of_month)
        readings = monthly_records.pluck(:reading)
        csv << [@start_day.beginning_of_month.strftime("%B %Y"), readings.max, readings.min, average(readings)]

        @start_day += 1.month
      end
    end
  end

  private

  def average(arr)
    arr.instance_eval { reduce(:+) / size.to_f }.round(2)
  end

  def fetch_dates
    # if there are no records then nothing will be exported
    @start_day = Date.today
    @end_day = 1.day.ago

    if @records.present?
      @start_day = @records.order(:created_at).first.created_at.to_date
      @end_day = @records.order(:created_at).last.created_at.to_date
    end
  end

end