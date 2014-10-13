class Survey < ActiveRecord::Base
  include Filterable
  has_many :fields, -> { order("priority ASC").includes(:field_choices) }, dependent: :destroy

  scope :guid, -> (guid) { where(guid: guid).first }
  store :opts, :accessors => [:intro_id, :outro_id, :logo_path], coder: JSON
  before_save :translate_slug

  validates :title, presence: true
  validates :guid, uniqueness: true

  def translate_slug
    self.guid = self.title.parameterize('-')
  end
end
