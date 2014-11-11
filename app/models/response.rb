class Response < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :team, inverse_of: :responses
  belongs_to :survey, inverse_of: :responses
  belongs_to :clinic, inverse_of: :responses
  belongs_to :provider, inverse_of: :responses
  has_many :answers, -> { includes :field }, autosave: true
  accepts_nested_attributes_for :answers, reject_if: proc { |attributes| attributes['value'].blank? }

  def time
    (self.ended_at.to_f - self.started_at.to_f).to_f
  end
end
