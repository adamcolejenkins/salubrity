module ResponsesHelper
  def is_number?
    true if Float(self) rescue false
  end
end
