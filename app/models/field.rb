class Field < ActiveRecord::Base
  include Filterable
  belongs_to :survey

  has_many :field_choices, -> { order :priority }, dependent: :destroy

  acts_as_list scope: :survey, column: :priority

  scope :type, -> (type) { where(type: type).first }

  after_create :create_field_choices

  validates :label, presence: true
  validates :field_type, presence: true
  validates :survey, presence: true

  store :opts, :accessors => [:field_size, :layout, :display_as, :instructions, :range_min, :range_max, :increment, :button_label, :button_mode, :button_url, :attachment_type, :attachment_url], coder: JSON

  def target_priority=(value)
    insert_at(value.to_i)
  end

  private

  def create_field_choices
    types = ["multiple_choice", "checkboxes", "dropdown"]
    if types.include?(self.field_type)
      self.field_choices.create!([
        {:key => "first_choice", :label => "First Choice"},
        {:key => "second_choice", :label => "Second Choice"},
        {:key => "third_choice", :label => "Third Choice"}
      ])
    end
  end
end
