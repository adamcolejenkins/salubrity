class DimensionsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.queued_for_write[:original].nil?
    # I'm not sure about this:
    dimensions = Paperclip::Geometry.from_file(value.queued_for_write[:original].path)
    # But this is what you need to know:
    width = options[:width]
    height = options[:height] 

    if dimensions.width < width || dimensions.height < height
      record.errors[attribute] << "image must be #{width}px by #{height}px."
    end
  end
end