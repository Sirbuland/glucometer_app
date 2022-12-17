class GlucometerReading < ApplicationRecord
  belongs_to :patient

  MAX_RECORDS_PER_DAY = 4

  validates :reading, presence: true
  validate :check_record_limit

  def record_date
    created_at.strftime("%d/%m/%Y")
  end

  def record_time
    created_at.strftime("%I:%M%p %Z")
  end

  private

  def check_record_limit
    if GlucometerReading.where(created_at: DateTime.now.beginning_of_day..DateTime.now).count >= MAX_RECORDS_PER_DAY
      errors.add(:base, "Only #{MAX_RECORDS_PER_DAY} allowed to be entered per day")
    end
  end
end
