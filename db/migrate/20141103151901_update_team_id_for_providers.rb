class UpdateTeamIdForProviders < ActiveRecord::Migration
  def up
    # say "Found #{Provider.with_deleted.where(team: nil).count} invalid provider(s)."

    # say_with_time "Updating providers..." do
    #   Clinic.with_deleted.each do |clinic|
    #     count = 0
    #     # Only update clinics without a team
    #     clinic.providers.with_deleted.where(team: nil).each do |provider|
    #       say "Updating provider: #{provider.name}"
    #       provider.update!(team: clinic.team)
    #       count += 1
    #     end
    #     count
    #   end
    # end

    # invalid_count = Provider.where(team: nil).count
    # fail "Found #{invalid_count} invalid record(s)." unless invalid_count == 0
  end
end
