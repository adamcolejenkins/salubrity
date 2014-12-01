class Answer < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :response
  belongs_to :field, inverse_of: :answers

  def time
    (self.ended_at.to_f - self.started_at.to_f).to_f
  end

  def response_value
    self.send(self.field.context + "_value")
  end

  private

  def dropdown_value
    choice_value
  end

  def multiple_choice_value
    choice_value
  end

  def paragraph_text_value
    value
  end

  def scale_value
    value
  end

  def single_line_text_value
    value
  end
  
  # Fields with FieldChoices
  def choice_value
    return choice.label unless choice.label.nil?
  end

  def choice
    self.field.field_choices.where(id: self.value).first
  end
  
end
