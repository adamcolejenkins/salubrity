class Field < ActiveRecord::Base
  include Filterable
  acts_as_paranoid
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

  DATA_EXCLUDE = %w(intro outro provider_dropdown)
  DATA_INCLUDE_PROVIDER = %w(intro outro)

  def target_priority=(value)
    insert_at(value.to_i)
  end

  def total_by_choice
    mem = self.field_choices.inject({}) { |mem, choice|
      mem[choice.label] = self.answers.where(value: choice.id.to_s).count
      mem
    }
    mem
  end

  def above_median
    self.answers.where(value: above_median_range)
  end

  def below_median
    self.answers.where(value: below_median_range)
  end

  def total_by_index
    logger.debug("START:: Field.total_by_index =========================================================")

    a = []
    i = self.range_min.to_i
    until i > self.range_max.to_i
      a[i] = (self.answers.where(value: i.to_s).count)
      i += self.increment.to_i
    end
    logger.debug("STOP:: Field.total_by_index =========================================================")
    a
  end

  def above_median_range
    (self.median.to_i..self.range_max.to_i).to_a.map(&:to_s)
  end

  def below_median_range
    (self.range_min.to_i..(self.median.to_i - 1)).to_a.map(&:to_s)
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
