class Clinic < ActiveRecord::Base
  include Filterable
  acts_as_paranoid
  belongs_to :team, inverse_of: :clinics
  belongs_to :survey, inverse_of: :clinics, counter_cache: true

  has_many :providers, -> { order(:surname) }, inverse_of: :clinic, dependent: :destroy
  has_many :responses, inverse_of: :clinic, dependent: :destroy
  has_many :devices, inverse_of: :clinic, dependent: :destroy

  before_validation :translate_slug, on: :create

  validates :title, presence: true
  validates :guid, presence: true, uniqueness: { scope: :survey, message: " exists for this survey." }, on: :update
  validates :survey_id, presence: true

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
  
  def average_time
    avg = 0.0
    self.responses.each_with_index do |response, index|
      avg = ((response.time + (avg * index.to_f)) / (index.to_f + 1)).to_f
    end

    Time.at(avg).utc.strftime("%M:%S")
  end

  def fields
    self.survey.fields
  end

  def data_fields
    self.survey.fields.includes(:field_choices).where.not(context: Field::DATA_EXCLUDE)
  end

  private

  def translate_slug
    self.guid = self.title.parameterize('-')
  end

end
