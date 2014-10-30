class AddTeamToProviders < ActiveRecord::Migration
  def change
    add_reference :providers, :team, index: true
  end
end
