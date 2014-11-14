class Provider < ActiveRecord::Base
  include Filterable, ChartData
  acts_as_paranoid

  # Exclude these field contexts in the dashboard
  DASHBOARD_CONTEXT_EXCLUDE = %w(intro outro provider_dropdown)

  belongs_to :team, inverse_of: :providers
  belongs_to :clinic, inverse_of: :providers
  
  has_many :responses, inverse_of: :provider

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
  validates_presence_of :clinic
  validates :email, presence: true, uniqueness: { scope: :clinic, message: " exists for this clinic." }

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

  private
  
end
