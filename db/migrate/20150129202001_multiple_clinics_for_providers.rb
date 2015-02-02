class MultipleClinicsForProviders < ActiveRecord::Migration
  def up
    # create the joins table
    create_join_table :providers, :clinics do |t|
      t.index [:provider_id, :clinic_id]
    end

    # define the old belongs_to clinic associate
    Provider.class_eval do
      belongs_to :old_clinic,
                 :class_name => "Clinic",
                 :foreign_key => "clinic_id"
    end

    # add the belongs_to clinic to the has_and_belongs_to_many clinics
    Provider.with_deleted.each do | provider |
      unless provider.old_clinic.nil?
        provider.clinics << provider.old_clinic
        provider.save
      end
    end

    # remove the old clinic_id column for the belongs_to associate
    remove_column :providers, :clinic_id
  end

  def down
    add_column :providers, :clinic_id, :integer

    Provider.class_eval do
      belongs_to :new_clinic,
                 :class_name => "Clinic",
                 :foreign_key => "clinic_id"
    end

    Provider.with_deleted.each do | provider |
      # NOTE: we'll grab the first clinic (if present), so if there are more, these will be lost!
      provider.new_clinic = provider.clinics.first unless provider.clinics.empty?
      provider.save
    end
    
    # Remove the joins table
    drop_join_table :providers, :clinics
  end
end
