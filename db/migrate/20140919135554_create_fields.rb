class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.references :survey, index: true
      t.text :label
      t.string :fieldType, limit: 30
      t.text :options
      t.integer :order, :null => false, :default => 0
      t.boolean :required
      t.string :visibility, :default => 'public'
      t.string :predefinedValue
      t.time :deleted_at

      t.timestamps
    end
  end
end
