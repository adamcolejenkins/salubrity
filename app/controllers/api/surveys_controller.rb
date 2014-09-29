class Api::SurveysController < Api::BaseController
  before_action :set_survey, only: [:show, :update, :destroy]
  skip_before_filter :authenticate_user, :only => :index

  # GET /api/surveys
  def index
    @surveys = Survey.filter(params.slice(:guid))
    render json: @surveys
  end

  # GET /api/surveys/1
  def show
    render json: @survey
  end

  # POST /api/surveys
  def create
    @survey = Survey.create!(safe_params)
    render json: @survey, status: :created
  end

  # PATCH/PUT /api/surveys/1
  def update
    @survey.update_attributes(safe_params)
    render json: @survey, status: :ok
  end

  # DELETE /api/surveys/1
  def destroy
    @survey.destroy
    render nothing: true
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_survey
    @survey ||= Survey.find(params[:id] || params[:guid])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def safe_params
    params.require(:survey).permit(:title, :description, :guid, :intro_id, :outro_id, :logo_path, :status, :scheduled, :scheduled_start, :scheduled_stop)
  end
end