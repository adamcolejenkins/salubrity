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

  def multiple_choice_chart
    @field = @survey.fields.find(params[:field_id])
    render json: @survey.data_for(:multiple_choice_field, field: @field)
  end

  def multiple_choice_color_chart
    @field = @survey.fields.find(params[:field_id])
    render json: @survey.data_for(:multiple_choice_field_colors, field: @field)
  end

  def set_survey
    @survey = current_team.surveys.find(params[:id])
  end
end
