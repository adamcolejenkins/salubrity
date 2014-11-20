class AddClinicsCacheToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :clinics_count, :integer
  end
end
