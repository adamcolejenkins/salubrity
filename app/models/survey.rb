class Survey < ActiveRecord::Base
  include Filterable, ChartData
  acts_as_paranoid

  belongs_to :team, :inverse_of => :surveys

  has_many :clinics, inverse_of: :survey, dependent: :destroy
  has_many :responses, inverse_of: :survey, dependent: :destroy
  has_many :fields, -> { order("priority ASC").includes(:field_choices) }, inverse_of: :survey, dependent: :destroy

  scope :guid, -> (guid) { where(guid: guid).first }
  store :opts, :accessors => [:intro_id, :outro_id, :logo_path], coder: JSON
  
  before_validation :translate_slug, on: :create

  validates :title, presence: true
  validates :guid, presence: true, uniqueness: { scope: :team, message: " exists for this team." }

  def translate_slug
    self.guid = self.title.parameterize('-')
  end

  def average_time
    logger.debug("START:: Survey.average_time =========================================================")
    @avg = 0.0
    i = 0
    self.responses.find_each do |response|
      @avg = ((response.time + (@avg * i.to_f)) / (i.to_f + 1)).to_f
      i += 1
    end
    logger.debug("STOP:: Survey.average_time =========================================================")
    Time.at(@avg).utc.strftime("%M:%S")
  end

  def clinics_count
    self.clinics.size
  end

  def providers_count
    self.clinics.includes(:providers).map { |c| c.providers.size }.inject(0) { |sum,item| sum + item }
  end

  def data_fields
    self.fields.includes(:field_choices).where.not(context: Field::DATA_EXCLUDE)
  end

end
