class Survey < ActiveRecord::Base
  include Filterable
  has_many :fields, -> { order :priority }, foreign_key: :survey_id, dependent: :destroy

  scope :guid, -> (guid) { where(guid: guid).first }
  store :opts, :accessors => [:intro_id, :outro_id, :logo_path], coder: JSON
  before_save :translate_slug

  validates :title, presence: true

  def translate_slug
    self.guid = self.title.parameterize('-')
  end
end
