class AlterOrderInTables < ActiveRecord::Migration
  def change
    remove_column :fields, :order
    remove_column :field_choices, :order

    add_column :fields, :priority, :integer, :after => :options
    add_column :field_choices, :priority, :integer, :after => :key
  end
end
