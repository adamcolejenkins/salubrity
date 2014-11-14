class UpdateFieldChoiceAnswers < ActiveRecord::Migration
  def change
    say_with_time "Updating answers..." do 
      # We only want the multiple choice fields
      Field.where(context: "multiple_choice").each do |field|
        say "- Getting field choices for field #{field.id}"

        field.field_choices.each do |choice|
          say "-- Updating choice #{choice.id}"

          field.answers.where(value: choice.key).each do |answer|
            say "--- Setting answer #{answer.id} value to #{choice.id}"

            answer.update!(value: choice.id)
          end
        end
      end
    end
  end
end
