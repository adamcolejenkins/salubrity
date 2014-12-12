class UpdateAnswerValuesForFieldChoices < ActiveRecord::Migration
  def change
    say_with_time "Updating answers..." do 
      # We only want the multiple choice fields
      Field.with_deleted.where(context: "multiple_choice").each do |field|
        say "- Getting field choices for field #{field.id}"

        field.field_choices.each do |choice|
          say "-- Updating choice #{choice.id}"

          field.answers.with_deleted.where(value: choice.id.to_s).each do |answer|
            say "--- Setting answer #{answer.id} value to #{choice.label}"

            answer.update!(value: choice.label)
          end
        end
      end
    end
  end
end
