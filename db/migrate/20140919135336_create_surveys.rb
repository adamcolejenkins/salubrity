class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title
      t.text :description
      t.string :guid, :unique => true
      t.string :logo_path
      t.string :status, :default => 'draft'
      t.boolean :scheduled, :default => false
      t.datetime :scheduled_start
      t.datetime :scheduled_stop
      t.time :deleted_at

      t.timestamps
    end
  end
end
