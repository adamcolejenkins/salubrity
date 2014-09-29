class CreateFieldOptions < ActiveRecord::Migration
  def change
    create_table :field_options do |t|
      t.references :field, index: true
      t.string :meta_key
      t.text :meta_value

      t.timestamps
    end
  end
end
