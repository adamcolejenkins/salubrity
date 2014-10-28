class AddTeamToSurveys < ActiveRecord::Migration
  def change
    add_reference :surveys, :team, index: true, :after => :id
  end
end
