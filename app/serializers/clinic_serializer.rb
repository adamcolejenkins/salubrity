class ClinicSerializer < ActiveModel::Serializer
  attributes :id, :title, :address, :address2, :city, :state, :zip, :phone, :guid, :providers
  has_one :survey
  has_many :providers
end
