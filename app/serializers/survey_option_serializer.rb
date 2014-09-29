class SurveyOptionSerializer < ActiveModel::Serializer

  def attributes
    hash = super
    hash[object.meta_key] = object.meta_value
    hash
  end
end
