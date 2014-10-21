class CreateClinics < ActiveRecord::Migration
  def change
    create_table :clinics do |t|
      t.string :title
      t.references :survey, index: true
      t.string :guid, :unique => true
      t.string :address
      t.string :address2
      t.string :city
      t.string :state, limit: 2
      t.integer :zip, limit: 6
      t.integer :phone
      t.string :guid

      t.timestamps
    end
  end
end
