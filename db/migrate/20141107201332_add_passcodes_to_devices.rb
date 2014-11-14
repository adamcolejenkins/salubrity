class AddPasscodesToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :access_passcode, :integer
    add_column :devices, :restriction_passcode, :integer
    add_column :devices, :guided_access_passcode, :integer
  end
end
