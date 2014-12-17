class Survey < ActiveRecord::Base
  include Filterable, ChartData
  acts_as_paranoid

  belongs_to :team, :inverse_of => :surveys

  has_many :clinics, inverse_of: :survey, dependent: :destroy
  has_many :responses, inverse_of: :survey, dependent: :destroy

  has_many :fields, -> { order("priority ASC") }, inverse_of: :survey, dependent: :destroy

  scope :guid, -> (guid) { where(guid: guid).first }
  store :opts, :accessors => [:intro_id, :outro_id, :logo_path], coder: JSON
  
  before_validation :translate_slug, on: :create

  validates :title, presence: true
  validates :guid, presence: true, uniqueness: { scope: :team, message: " exists for this team." }

  def translate_slug
    self.guid = self.title.parameterize('-')
  end

  # Calculates the average time for responses
  def average_time
    return nil if self.responses.size == 0
    Time.at( self.responses.map(&:time).inject([0.0,0]) { |r,el| [r[0]+el, r[1]+1] }.inject(:/) ).utc.strftime("%H:%S") unless count == 0
  end

  def clinics_count
    self.clinics.count
  end

  def providers_count
    self.clinics.includes(:providers).map { |c| c.providers.length }.inject(0) { |sum,item| sum + item }
  end

  def data_fields
    self.fields.where.not(context: Field::DATA_EXCLUDE)
  end

end
