class CreateFieldChoices < ActiveRecord::Migration
  def change
    create_table :field_choices do |t|
      t.references :field, index: true
      t.string :label
      t.string :key
      t.integer :order, :null => false, :default => 0
      t.time :deleted_at

      t.timestamps
    end
  end
end
