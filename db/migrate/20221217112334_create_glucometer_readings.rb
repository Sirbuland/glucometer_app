class CreateGlucometerReadings < ActiveRecord::Migration[7.0]
  def change
    create_table :glucometer_readings do |t|
      t.integer :patient_id
      t.integer :reading

      t.timestamps
    end
  end
end
