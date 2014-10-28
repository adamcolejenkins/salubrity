class DropLogoFromTeams < ActiveRecord::Migration
  def change
    remove_column :teams, :logo
  end
end
