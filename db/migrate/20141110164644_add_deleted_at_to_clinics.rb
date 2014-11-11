class AddDeletedAtToClinics < ActiveRecord::Migration
  def change
    add_column :clinics, :deleted_at, :datetime
  end
end
