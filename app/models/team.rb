class Team < ActiveRecord::Base
  has_many :users, inverse_of: :team, dependent: :destroy
  has_many :surveys, inverse_of: :team, dependent: :destroy
  has_many :clinics, inverse_of: :team, dependent: :destroy
  has_many :providers, inverse_of: :team, dependent: :destroy
  has_many :responses, inverse_of: :team, dependent: :destroy

  RESERVED_SUBDOMAINS = %w(
    admin api assets blog calendar demo developer developers docs files ftp git imap lab mail manage mx pages pop sites smtp ssl staging status support www help news account log
  )

  # Accept user attrs on create
  accepts_nested_attributes_for :users
  
  # Before we validate on create, translate the subdomain
  before_validation :translate_subdomain, on: :create

  # This method associates the attribute ":logo" with a file attachment
  has_attached_file :logo, 
    styles: {
      large: "800x280>",
      medium: "400x140>",
      thumb: "200x70>"
    },
    convert_options: {
      large: "-strip",
      medium: "-strip"
    }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  # Validate the attached image is at least 400x140
  validates :logo, dimensions: { width: 400, height: 140 }

  # Validate the name is present
  validates :name, presence: true

  # Validate the subdomain is unique and not reserved on create
  validates :subdomain, uniqueness: true, exclusion: { in: RESERVED_SUBDOMAINS,
    message: "'%{value}' is reserved, please try another one." }, on: :create

  private

  # Translate the subdomain to a parameterized version
  # this-is-an-example
  def translate_subdomain
    self.subdomain = self.name.parameterize('-')
  end

  # Model to String converstion, displays name
  def to_s
    name
  end
end
