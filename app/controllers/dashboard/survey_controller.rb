class Dashboard::SurveyController < ApplicationController
  before_filter :set_survey, only: [:chart]
  layout 'angular'

  def index
    @surveys = current_team.surveys.all
  end

  def chart
    self.send("#{params[:chart]}_chart")
  end
  
  private

  def responses_chart
    render json: @survey.responses.group_by_day(:created_at, format: "%A, %B %e").count
  end

  def timing_chart
    render json: @survey.responses.daily_avg_time
  end

  def set_survey
    @survey = current_team.surveys.find(params[:id])
  end
end
