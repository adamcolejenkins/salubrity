class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.references :team, index: true
      t.references :survey, index: true
      t.references :clinic, index: true
      t.string :udid
      t.string :imei
      t.string :os
      t.string :os_version
      t.string :version
      t.string :product
      t.string :color
      t.boolean :active, default: false

      t.timestamps
    end

    add_index :devices, :udid, unique: true
  end
end
