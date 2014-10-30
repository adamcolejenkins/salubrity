class Clinic < ActiveRecord::Base
  belongs_to :survey, inverse_of: :clinics
  belongs_to :team, inverse_of: :clinics
  has_many :providers, -> { order(:name) }, inverse_of: :clinic, dependent: :destroy
  has_many :responses, inverse_of: :clinic

  before_validation :translate_slug, on: :create

  validates :title, presence: true
  validates :guid, presence: true, uniqueness: { scope: :survey, message: " exists for this survey." }

  # This method associates the attribute ":background" with a file attachment
  has_attached_file :background, 
    styles: {
      large: "1920x1200>",
      medium: "1024x768>",
      thumb: "384x216>"
    }, 
    convert_options: {
      large: "-quality 75 -strip",
      medium: "-quality 75 -strip"
    }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :background, :content_type => /\Aimage\/.*\Z/
  validates :background, :dimensions => { :width => 1920, :height => 1200 }
  
  private

  def translate_slug
    self.guid = self.title.parameterize('-')
  end

  def to_s
    title
  end
end
