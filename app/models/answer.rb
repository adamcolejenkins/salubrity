class Answer < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :response
  belongs_to :field, inverse_of: :answers

  belongs_to :field_choices

  def time
    (self.ended_at.to_f - self.started_at.to_f).to_i
  end

  private
  
end
