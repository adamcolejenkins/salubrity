class SurveyOption < ActiveRecord::Base
  belongs_to :survey

  serialize :meta_value

  validates :meta_key, presence: true
  validates :meta_value, presence: true
end
