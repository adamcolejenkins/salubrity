class Answer < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :response
  belongs_to :field, inverse_of: :answers

  belongs_to :field_choices

  def time
    (self.ended_at.to_f - self.started_at.to_f).to_i
  end

  def self.average_time
    Time.at( all.map(&:time).inject([0.0,0]) { |r,el| [r[0]+el, r[1]+1] }.inject(:/) ).utc.strftime("%H:%S") unless count == 0
  end

  private
  
end
