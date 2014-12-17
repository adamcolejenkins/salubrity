class Response < ActiveRecord::Base
  include Filterable

  acts_as_paranoid
  belongs_to :team, inverse_of: :responses
  belongs_to :survey, inverse_of: :responses
  belongs_to :clinic, inverse_of: :responses
  belongs_to :provider, inverse_of: :responses
  has_many :answers, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :answers, reject_if: proc { |attributes| attributes['value'].nil? }

  scope :between, lambda { |start_date, end_date|
    start_date ||= Time.now
    end_date ||= Time.now
    where("responses.created_at >= ? AND responses.created_at <= ?", start_date.beginning_of_day, end_date.end_of_day )
  }

  # scope :start,    -> (start)       { where("created_at >= ?", start.beginning_of_day) }
  # scope :stop,     -> (stop)        { where("created_at <= ?", stop.end_of_day) }
  scope :survey,   -> (survey_id)   { where survey_id: survey_id }
  scope :clinic,   -> (clinic_id)   { where clinic_id: clinic_id }
  scope :provider, -> (provider_id) { where provider_id: provider_id }

  def time
    (self.ended_at.to_f - self.started_at.to_f).to_i
  end

  def self.average_time
    Time.at( all.map(&:time).inject([0.0,0]) { |r,el| [r[0]+el, r[1]+1] }.inject(:/) ).utc.strftime("%H:%S") unless count == 0
  end
  
  # def self.field_total(field)
  #   logger.debug("START:: Response.field_total =========================================================")
  #   a = []
  #   i = field.range_min.to_i
  #   until i > field.range_max.to_i
  #     a[i] = total_answers resource: self, where: { field: field, value: i.to_s }
  #     i += field.increment.to_i
  #   end
  #   logger.debug("START:: Response.field_total =========================================================")
  #   a.to_json
  # end

  def self.active
    self.joins(:provider, :clinic)
  end

  # def created_at
  #   read_attribute(:created_at).strftime("%m/%d/%Y at %H:%M:%S")
  # end

end
