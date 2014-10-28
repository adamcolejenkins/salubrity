class Survey < ActiveRecord::Base
  include Filterable
  belongs_to :team, :inverse_of => :surveys

  has_many :fields, -> { order("priority ASC").includes(:field_choices) }, inverse_of: :survey, dependent: :destroy
  has_many :clinics, inverse_of: :survey, dependent: :destroy

  scope :guid, -> (guid) { where(guid: guid).first }
  store :opts, :accessors => [:intro_id, :outro_id, :logo_path], coder: JSON
  before_save :translate_slug

  validates :title, presence: true
  validates :guid, uniqueness: true

  def translate_slug
    self.guid = self.title.parameterize('-')
  end

  def to_s
    title
  end
end
