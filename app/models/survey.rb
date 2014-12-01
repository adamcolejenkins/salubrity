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
    @avg = 0.0
    self.responses.each_with_index do |response, index|
      @avg = ((response.time + (@avg * index.to_f)) / (index.to_f + 1)).to_f
    end

    Time.at(@avg).utc.strftime("%M:%S")
  end

  def clinics_count
    self.clinics.size
  end

  def providers_count
    self.clinics.map { |c| c.providers.size }.inject(0) { |sum,item| sum + item }
  end

  def data_fields
    self.fields.includes(:field_choices).where.not(context: Field::DATA_EXCLUDE)
  end

end
