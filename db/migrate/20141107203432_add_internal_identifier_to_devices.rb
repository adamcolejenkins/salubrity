class AddInternalIdentifierToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :internal_identifier, :string
    add_index :devices, :internal_identifier, unique: true
  end
end
