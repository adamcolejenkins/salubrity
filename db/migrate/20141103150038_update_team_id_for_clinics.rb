class UpdateTeamIdForClinics < ActiveRecord::Migration
  def up
    # say "Found #{Clinic.with_deleted.where(team: nil).count} invalid clinic(s)."

    # say_with_time "Updating clinics..." do
    #   Survey.with_deleted.each do |survey|
    #     count = 0
    #     # Only update clinics without a team
    #     survey.clinics.with_deleted.where(team: nil).each do |clinic|
    #       say "Updating clinic: #{clinic.title}"
    #       clinic.update!(team: survey.team)
    #       count += 1
    #     end
    #     count
    #   end
    # end

    # invalid_count = Clinic.where(team: nil).count
    # fail "Found #{invalid_count} invalid record(s)." unless invalid_count == 0
  end
end
