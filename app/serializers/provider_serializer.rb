class ProviderSerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :email, :phone, :clinic, :photo, :created_at, :updated_at
end
