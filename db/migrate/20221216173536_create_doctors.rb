class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|
      t.integer :user_id
      t.string :speciality
      # More doctor related fields should come here

      t.timestamps
    end
  end
end
