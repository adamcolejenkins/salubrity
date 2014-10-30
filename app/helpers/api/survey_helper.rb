module Api::SurveyHelper
  def status
    [
      ["Draft", "draft"],
      ["Published", "published"]
    ]  
  end  
end
