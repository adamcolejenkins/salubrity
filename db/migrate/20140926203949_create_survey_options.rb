class CreateSurveyOptions < ActiveRecord::Migration
  def change
    create_table :survey_options do |t|
      t.references :survey, index: true
      t.string :meta_key
      t.text :meta_value

      t.timestamps
    end
  end
end
