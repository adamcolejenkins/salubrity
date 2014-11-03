class Provider < ActiveRecord::Base

  # Exclude these field contexts in the dashboard
  DASHBOARD_CONTEXT_EXCLUDE = %w(intro outro provider_dropdown)

  belongs_to :team, inverse_of: :providers
  belongs_to :clinic, inverse_of: :providers
  
  has_many :responses, inverse_of: :provider

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

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { scope: :clinic, message: " exists for this clinic." }
  validates_presence_of :clinic
  
end
