class Provider < ActiveRecord::Base
  include Filterable
  acts_as_paranoid

  # default_scope { order('providers.surname ASC') }

  # Exclude these field contexts in the dashboard
  DASHBOARD_CONTEXT_EXCLUDE = %w(intro outro provider_dropdown)

  belongs_to :team, inverse_of: :providers

  belongs_to :clinic, inverse_of: :providers # remove this later
  has_and_belongs_to_many :clinics
  
  has_many :responses, inverse_of: :provider, dependent: :destroy

  # Strip attributes from whitespaces
  auto_strip_attributes :name, :surname, :credential, :email

  # This method associates the attribute ":logo" with a file attachment
  has_attached_file :photo, 
    styles: {
      large: "800x640>",
      medium: "400x320>",
      thumb: "200x160>"
    },
    convert_options: {
      large: "-strip",
      medium: "-strip"
    }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  # Validate the attached image is at least 800x640
  validates :photo, :dimensions => { :width => 800, :height => 640 }

  validates_presence_of :name
  validates_presence_of :surname

  def average_time
    avg = 0.0
    self.responses.each_with_index do |response, index|
      avg = ((response.time + (avg * index.to_f)) / (index.to_f + 1)).to_f
    end

    Time.at(avg).utc.strftime("%M:%S")
  end

  def fields
    self.clinic.survey.fields
  end

  def full_name
    "#{self.name} #{self.surname}, #{self.credential}"
  end

  def full_name_surname_first
    "#{self.surname} #{self.credential}, #{self.name}"
  end

  def data_fields
    self.clinic.survey.fields.includes(:field_choices).where.not(context: Field::DATA_EXCLUDE)
  end

  def data
    
  end

  private

  def require_at_least_one_clinic
    if clinics.count == 0
      errors.add :clinic_ids, "Please select at least one Clinic"
    end
  end

  def flat_number
    phone.gsub(/[^0-9]/, '')
  end
  
end
