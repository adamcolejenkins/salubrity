class Survey < ActiveRecord::Base
  include Filterable
  has_many :fields, -> { order :priority }, foreign_key: :survey_id, dependent: :destroy

  scope :guid, -> (guid) { where(guid: guid).first }

  validates :title, presence: true
  validates :guid, presence: true
end
