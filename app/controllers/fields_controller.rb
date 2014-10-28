class FieldsController < ApplicationController
  before_filter :authenticate_user!
  layout 'angular'

  add_breadcrumb "← Back to Surveys", :surveys_path

  def index
    @survey = current_team.surveys.find(params[:survey_id])
  end
end
