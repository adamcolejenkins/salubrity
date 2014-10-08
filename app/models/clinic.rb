class Clinic < ActiveRecord::Base
  belongs_to :survey
  has_many :providers, -> { order :name }, dependent: :destroy
  
  before_save :translate_slug
  validates :title, presence: true
  # validates :guid, presence: true, uniqueness: true
  

  private

  def translate_slug
    self.guid = self.title.parameterize('-')
  end
end
