class Field < ActiveRecord::Base
  belongs_to :survey

  has_many :field_choices, -> { order :priority }, dependent: :destroy

  acts_as_list scope: :survey, column: :priority

  validates :label, presence: true
  validates :field_type, presence: true
  validates :survey, presence: true

  store :opts, :accessors => [:field_size, :layout, :display_as, :instructions, :range_min, :range_max, :increment], coder: JSON

  def target_priority=(value)
    insert_at(value.to_i)
  end
end
