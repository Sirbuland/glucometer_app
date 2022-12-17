class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.integer :user_id
      # Patient specific fields

      t.timestamps
    end
  end
end
