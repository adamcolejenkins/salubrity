class AddTeamToResponses < ActiveRecord::Migration
  def change
    add_reference :responses, :team, index: true
  end
end
