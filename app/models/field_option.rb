class FieldOption < ActiveRecord::Base
  belongs_to :field

  validates :meta_key, presence: true
  validates :meta_value, presence: true
end
