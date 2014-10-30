class AddAttachmentBackgroundToClinics < ActiveRecord::Migration
  def self.up
    change_table :clinics do |t|
      t.attachment :background
    end
  end

  def self.down
    remove_attachment :clinics, :background
  end
end
