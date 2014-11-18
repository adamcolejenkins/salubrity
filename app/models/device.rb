class Device < ActiveRecord::Base
  belongs_to :team
  belongs_to :clinic

  validates :udid, uniqueness: true, on: :update
  validates :internal_identifier, uniqueness: true

  def update_profile_service_attributes!(response_attributes)
    self.product = response_attributes.value['PRODUCT'].value
    self.udid    = response_attributes.value['UDID'].value
    self.version = response_attributes.value['VERSION'].value
    self.serial  = response_attributes.value['ICCID'].value
    save
  end
end
