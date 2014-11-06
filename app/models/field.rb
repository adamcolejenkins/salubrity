class Field < ActiveRecord::Base
  include Filterable
  belongs_to :survey, inverse_of: :fields
  has_many :field_choices, -> { order "priority ASC" }, dependent: :destroy
  has_many :answers, inverse_of: :field, dependent: :destroy

  acts_as_list scope: :survey, column: :priority

  scope :context, -> (context) { where(context: type).first }

  after_create :create_field_choices

  validates :label, presence: true
  validates :context, presence: true
  validates :survey, presence: true

  store :opts, :accessors => [:field_size, :layout, :display_as, :instructions, :range_min, :range_max, :increment, :median, :button_label, :button_mode, :button_url, :attachment_type, :attachment_url], coder: JSON

  def target_priority=(value)
    insert_at(value.to_i)
  end

  def data
    
  end

  private

  def create_field_choices
    contexts = ["multiple_choice", "checkboxes", "dropdown"]
    if contexts.include?(self.context)
      self.field_choices.create!([
        {:key => "first_choice", :label => "First Choice"},
        {:key => "second_choice", :label => "Second Choice"},
        {:key => "third_choice", :label => "Third Choice"}
      ])
    end
  end

end
