class MultipleSurveysForClinics < ActiveRecord::Migration
  def up
    # create the joins table
    create_join_table :clinics, :surveys do |t|
      t.index [:clinic_id, :survey_id]
    end

    # define the old belongs_to survey associate
    Clinic.class_eval do
      belongs_to :old_survey,
                 :class_name => 'Survey',
                 :foreign_key => 'survey_id'
    end

    # add the belongs_to survey to the has_and_belongs_to_many surveys
    Clinic.with_deleted.each do | clinic |
      unless clinic.old_survey.nil?
        clinic.surveys << clinic.old_survey
        clinic.save
      end
    end

    # remove the old survey_id column for the belongs_to associate
    remove_column :clinics, :survey_id
  end
  def down
    add_column :clinics, :survey_id, :integer

    Clinic.class_eval do
      belongs_to :new_survey,
                 :class_name => "Survey",
                 :foreign_key => "survey_id"
    end

    Clinic.with_deleted.each do | clinic |
      # NOTE: we'll grab the first survey (if present), so if there are more, they will be lost!
      clinic.new_survey = clinic.surveys.first unless clinic.surveys.empty?
      clinic.save
    end

    # remove the joins table
    drop_join_table :clinics, :surveys
  end
end
