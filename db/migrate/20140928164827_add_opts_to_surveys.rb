class AddOptsToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :opts, :text
    remove_column :surveys, :logo_path
  end
end
