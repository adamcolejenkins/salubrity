class AddTeamToClinics < ActiveRecord::Migration
  def change
    add_reference :clinics, :team, index: true
  end
end
