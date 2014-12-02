class FieldChoice < ActiveRecord::Base
  belongs_to :field

  has_many :answers, through: :field

  acts_as_list scope: :field, column: :priority, add_new_at: :bottom
  before_create :translate_key
  before_update :translate_key

  validates :label, presence: true
  validates :field, presence: true

  def target_priority=(value)
    insert_at(value.to_i)
  end

  def translate_key
    self.key = self.label.parameterize('_')
  end
  
end
