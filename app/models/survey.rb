class Survey < ActiveRecord::Base
  include Filterable
  has_many :fields, -> { order :priority }, foreign_key: :survey_id, dependent: :destroy

  scope :guid, -> (guid) { where(guid: guid).first }

  store :opts, :accessors => [:intro_id, :outro_id, :logo_path], coder: JSON

  validates :title, presence: true
  validates :guid, presence: true
end
