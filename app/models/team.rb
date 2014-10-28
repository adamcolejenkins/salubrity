class Team < ActiveRecord::Base
  has_many :users, inverse_of: :team, dependent: :destroy
  has_many :surveys, inverse_of: :team, dependent: :destroy
  has_many :clinics, inverse_of: :team, dependent: :destroy
  has_many :providers, inverse_of: :team, dependent: :destroy

  accepts_nested_attributes_for :users
  before_validation :translate_subdomain

  has_attached_file :logo, :styles => { :medium => "400x140>", :thumb => "200x70>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  validates :name, presence: true, uniqueness: true
  validates :subdomain, uniqueness: true, exclusion: { in: %w(www api account),
    message: "'%{value}' is reserved." }, on: :create

  private

  def translate_subdomain
    self.subdomain = self.name.parameterize('-')
  end

  def to_s
    name
  end
end
