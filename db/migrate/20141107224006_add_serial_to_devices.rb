class AddSerialToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :serial, :string
  end
end
