class UpdateTeamIdForResponses < ActiveRecord::Migration
  def change
    say "Found #{Response.with_deleted.where(team_id: nil).count} teamless responses."

    say_with_time "Updating responses..." do
      Response.with_deleted.where(team_id: nil).each do |response|
        say "Linking response #{response.id} to team #{response.survey.team.id}"

        response.update!(team_id: response.survey.team.id)
      end
    end
  end
end
