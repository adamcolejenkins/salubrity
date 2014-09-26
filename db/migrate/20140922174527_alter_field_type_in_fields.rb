class AlterFieldTypeInFields < ActiveRecord::Migration
  def change
    rename_column :fields, :fieldType, :field_type
    rename_column :fields, :predefinedValue, :predefined_value
  end
end
