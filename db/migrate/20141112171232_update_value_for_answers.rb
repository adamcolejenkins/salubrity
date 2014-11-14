class UpdateValueForAnswers < ActiveRecord::Migration
  def change
    say_with_time "Updating answer..." do
      count = 0
      Answer.all.each do |answer|
        case answer.value
        when "another_choice"
          say "Updating answer #{answer.id}: #{answer.value}"
          answer.update!(value: "always")
        when "second_choice"
          say "Updating answer #{answer.id}: #{answer.value}"
          answer.update!(value: "sometimes")
        when "third_choice"
          say "Updating answer #{answer.id}: #{answer.value}"
          answer.update!(value: "usually")
        when "almost_always"
          say "Updating answer #{answer.id}: #{answer.value}"
          answer.update!(value: "usually")
        when "almost_never"
          say "Updating answer #{answer.id}: #{answer.value}"
          answer.update!(value: "sometimes")
        end
        count += 1
      end
      count
    end
  end
end
