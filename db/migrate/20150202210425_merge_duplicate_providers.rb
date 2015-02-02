class MergeDuplicateProviders < ActiveRecord::Migration
  def change
    say "Found #{Provider.with_deleted.select(:email).group(:email).having("count(*) > 1").length} duplicate providers."

    say_with_time "Merging providers..." do
      count = 0

      # Query & loop email addresses found with more than one provider
      Provider.with_deleted.select(:email).group(:email).having("count(*) > 1").each do |duplicate|
        
        # Query providers with the matched email address
        providers = Provider.with_deleted.where(email: duplicate.email)
        say "Found #{providers.count} duplicate providers with email #{duplicate.email}"

        # Set a primary provider to merge others into
        primary = providers.first
        say "Provider #{primary.id} will be PRIMARY..."

        # Loop through remaining providers (typically one provider)
        providers.each_with_index do |provider, index|

          next if provider.id == primary.id
          
          say "Adding #{provider.clinics.count} clinic(s) to PRIMARY provider #{primary.id}"
          primary.clinics << provider.clinics

          say "PRIMARY provider #{primary.id} now belongs to #{primary.clinics.count} clinic(s)."
          primary.save

          # Update duplicate provider responses to have primary provider_id
          unless provider.responses.count == 0
            say "Moving #{provider.responses.count} responses to PRIMARY provider #{primary.id} from DUPLICATE provider #{provider.id}"
            provider.responses.update_all(provider_id: primary.id)
          end

          # Really destroy the duplicate provider if all responses have moved over
          unless provider.responses.count > 0
            provider.really_destroy!
            say "> Destroyed provider #{provider.id}"
          # Or archive duplicate provider so we can manually do it
          else
            provider.destroy
            say "!!! DUPLICATE provider #{provider.id} was archived, but there are still #{provider.responses.count} responses that need to be moved. !!!"
          end


          say "Next duplicate..." unless index == (providers.length - 1)
        end
        count += 1

        say "Next email...\n\n"
      end
      count
    end

    invalid_count = Provider.with_deleted.select(:email).group(:email).having("count(*) > 1").length
    fail "Found #{invalid_count} invalid records" unless invalid_count == 0
  end
end
