class Provider < ActiveRecord::Base
  belongs_to :clinic, inverse_of: :providers

  has_attached_file :logo, :styles => { :medium => "400x140>", :thumb => "200x70>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :position, presence: true
  validates :email, presence: true
  validates :phone, presence: true
  validates :clinic, presence: true

  def to_s
    name
  end
end
