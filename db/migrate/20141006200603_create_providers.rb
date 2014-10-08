class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.references :clinic, index: true
      t.string :name
      t.string :position
      t.string :email
      t.string :phone
      t.string :photo

      t.timestamps
    end
  end
end
