class Clinic < ActiveRecord::Base
  belongs_to :survey, inverse_of: :clinics
  belongs_to :team, inverse_of: :clinics
  has_many :providers, -> { order(:name) }, inverse_of: :clinic, dependent: :destroy
  
  before_save :translate_slug
  validates :title, presence: true
  validates :guid, presence: true, uniqueness: true
  

  private

  def translate_slug
    self.guid = self.title.parameterize('-')
  end

  def to_s
    title
  end
end
