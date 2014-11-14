class Device < ActiveRecord::Base
  belongs_to :team
  belongs_to :clinic

  # validates :udid, presence: true, uniqueness: true

  def update_profile_service_attributes!(response_attributes)
    self.product = response_attributes.value['PRODUCT'].value
    self.udid    = response_attributes.value['UDID'].value
    self.version = response_attributes.value['VERSION'].value
    self.serial  = response_attributes.value['SERIAL'].value
    save
  end
end
