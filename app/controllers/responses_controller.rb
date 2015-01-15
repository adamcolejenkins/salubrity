class ResponsesController < ApplicationController
  # load_and_authorize_resource
  before_action :set_group_date_options, :set_default_params, :format_dates, :set_resources
  before_action :set_survey, only: [:index, :clinic_usage_chart]
  before_action :set_responses
  layout 'angular'

  def index
    @current_survey = current_survey_id.to_i

    respond_to do |format|
      format.html
      format.json { render json: ResponseDatatable.new(view_context) }
      format.xls
    end
  end

  def recent_responses_chart
    case params[:filter]
    when 'day'
      render json: @responses.group_by_hour(
        'responses.created_at', 
        range: (params[:from].beginning_of_day + 6.hours)..(params[:to].end_of_day - 5.hours),
        format: "%l %P"
      ).count
    else
      render json: @responses.group_by_day('responses.created_at', range: params[:from]..params[:to], format: "%b %d").count
    end
  end

  def clinic_usage_chart
    case params[:filter]
    when 'day'
      render json: @survey.clinics.filter(params.slice(:clinic)).map { |clinic| 
        { 
          name: clinic.title, 
          data: clinic.responses.filter(params.slice(:provider)).group_by_hour('responses.created_at', 
            range: (params[:from].beginning_of_day + 6.hours)..(params[:to].end_of_day - 5.hours), 
            format: "%l %P"
          ).count
        }
      }
    when 'month'
      render json: @survey.clinics.filter(params.slice(:clinic)).map { |clinic| 
        { 
          name: clinic.title, 
          data: clinic.responses.filter(params.slice(:provider))
                      .group_by_week('responses.created_at', range: params[:from]..params[:to], format: "%b %d").count }
      }
    else
      render json: @survey.clinics.filter(params.slice(:clinic)).map { |clinic| 
        { 
          name: clinic.title, 
          data: clinic.responses.filter(params.slice(:provider))
                      .group_by_day('responses.created_at', range: params[:from]..params[:to], format: "%b %d").count }
      }
    end
  end

  def multiple_choice_chart
    render json: @responses.joins(:answers).where('answers.field_id = ?', params[:field]).group('answers.value').count
  end

  private

  def set_default_params
    params[:from] ||= Date.today
    params[:to] ||= Date.today
    params[:filter] ||= 'day'

    case params[:filter]
      when 'week'
        @filter = 1.week
      when 'month'
        @filter = 1.month
      else
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

  def set_responses
    @responses ||= current_team.responses.active.between(params[:from], params[:to]).filter(params.slice(:limit, :survey, :clinic, :provider))
  end

  def set_group_date_options
    Groupdate.time_zone = "America/Chicago"
    Groupdate.week_start = :mon
    Groupdate.day_start = 6
  end

end
