class Team < ActiveRecord::Base
  has_many :users, :inverse_of => :team, :dependent => :destroy
  has_many :surveys, :inverse_of => :team, :dependent => :destroy
  has_many :clinics, :inverse_of => :team, :dependent => :destroy
  has_many :providers, :inverse_of => :team, :dependent => :destroy
  accepts_nested_attributes_for :users
  before_validation :translate_subdomain

  validates :name, presence: true
  validates :subdomain, uniqueness: true, on: :create

  private

  def translate_subdomain
    self.subdomain = self.name.parameterize('-')
  end
end
