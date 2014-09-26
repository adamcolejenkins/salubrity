class FieldChoice < ActiveRecord::Base
  belongs_to :field

  acts_as_list scope: :field, column: :priority, add_new_at: :bottom

  validates :label, presence: true
  validates :key, presence: true
  validates :field, presence: true

  def target_priority=(value)
    insert_at(value.to_i)
  end
end
