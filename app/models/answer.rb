class Answer < ActiveRecord::Base
  belongs_to :response
  belongs_to :field, inverse_of: :answers

  def time
    (self.ended_at.to_f - self.started_at.to_f).to_f
  end
  
end
