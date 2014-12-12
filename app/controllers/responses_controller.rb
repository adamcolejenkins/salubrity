class ResponsesController < ApplicationController
  before_action :set_default_params, :format_dates, :set_resources, :set_survey
  layout 'angular'

  def index
    @current_survey = current_survey_id.to_i
    @responses = current_team.responses.between(params[:from], params[:to]).filter(params.slice(:limit, :survey, :clinic, :provider))

    respond_to do |format|
      format.html
      format.json { render json: ResponseDatatable.new(view_context) }
    end
  end

  def recent_responses_chart
    case params[:filter]
    when 'day'
      render json: current_team.responses.group_by_hour(:created_at, range: params[:from].midnight..params[:to].end_of_day, format: "%l %P").count
    else
      render json: current_team.responses.group_by_day(:created_at, range: params[:from]..params[:to], format: "%B %d, %Y").count
    end
  end

  def clinic_usage_chart
    case params[:filter]
    when 'day'
      render json: @survey.clinics.map { |clinic| 
        { name: clinic.title, data: clinic.responses.group_by_hour(:created_at, range: params[:from].midnight..params[:to].end_of_day, format: "%l %P").count }
      }
    else
      render json: @survey.clinics.map { |clinic| 
        { name: clinic.title, data: clinic.responses.group_by_day(:created_at, range: params[:from]..params[:to], format: "%B %d, %Y").count }
      }
    end
  end

  private

  def set_default_params
    params[:from] ||= Date.today
    params[:to] ||= Date.today

    case params[:filter]
      when 'week'
        @filter = 1.week
      when 'month'
        @filter = 1.month
      else
        params[:filter] = 'day'
        @filter = 1.day
    end
  end

  def format_dates
    params[:from] = params[:from].to_date unless params[:from].nil?
    params[:to] = params[:to].to_date unless params[:to].nil?
  end

  def set_resources
    @surveys = current_team.surveys.all
    @clinics = current_team.clinics.all
    @providers = current_team.providers.all
  end

  def current_survey_id
    params[:survey] ||= @surveys.first.id
  end

  def set_survey
    @survey ||= current_team.surveys.find(current_survey_id)
  end

end
