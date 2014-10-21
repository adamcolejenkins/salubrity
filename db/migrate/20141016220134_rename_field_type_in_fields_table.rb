class RenameFieldTypeInFieldsTable < ActiveRecord::Migration
  def change
    rename_column :fields, :field_type, :context
  end
end
