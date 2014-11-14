class UpdateColorForFieldChoices < ActiveRecord::Migration
  def up
    say "Found #{FieldChoice.where(color: nil).count} bland field choice(s)."

    say_with_time "Updating field choice..." do
      count = 0
      FieldChoice.where(color: nil).each do |choice|
        # Update colors by key
        case choice.key
        when "never"
          say "Updating choice #{choice.id}: #{choice.label}"
          choice.update!(color: "#da645a")
        when "sometimes"
          say "Updating choice #{choice.id}: #{choice.label}"
          choice.update!(color: "#f3ae73")
        when "usually"
          say "Updating choice #{choice.id}: #{choice.label}"
          choice.update!(color: "#b0c47f")
        when "always"
          say "Updating choice #{choice.id}: #{choice.label}"
          choice.update!(color: "#588c75")
        end
        count += 1
      end
      count
    end

    invalid_count = FieldChoice.where(color: nil).count
    fail "Found #{invalid_count} invalid record(s)." unless invalid_count == 0
  end
end
