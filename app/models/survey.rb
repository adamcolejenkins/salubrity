class Survey < ActiveRecord::Base
  include Filterable
  belongs_to :team, :inverse_of => :surveys

  has_many :fields, -> { order("priority ASC").includes(:field_choices) }, inverse_of: :survey, dependent: :destroy
  has_many :clinics, inverse_of: :survey, dependent: :destroy
  has_many :responses, inverse_of: :survey

  scope :guid, -> (guid) { where(guid: guid).first }
  store :opts, :accessors => [:intro_id, :outro_id, :logo_path], coder: JSON
  
  before_validation :translate_slug, on: :create

  validates :title, presence: true
  validates :guid, presence: true, uniqueness: { scope: :team, message: " exists for this team." }

  def translate_slug
    self.guid = self.title.parameterize('-')
  end

  def to_s
    title
  end
end
