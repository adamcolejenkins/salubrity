class Provider < ActiveRecord::Base
  belongs_to :clinic

  validates :name, presence: true
  validates :position, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :clinic, presence: true
end
