class FieldsController < ApplicationController
  before_filter :authenticate_user!
  layout 'angular'

  def index
    @survey = current_team.surveys.find(params[:survey_id])
  end
end
