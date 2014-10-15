class Response < ActiveRecord::Base
  belongs_to :survey
  belongs_to :clinic
  belongs_to :provider
  has_many :answers, -> { includes :field }
  accepts_nested_attributes_for :answers
end
