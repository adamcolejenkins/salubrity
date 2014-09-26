class RenameOptionsInFields < ActiveRecord::Migration
  def change
    rename_column :fields, :options, :opts
  end
end
