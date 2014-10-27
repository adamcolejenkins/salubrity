class Api::SurveysController < Api::BaseController
  before_action :set_survey, only: [:show, :update, :destroy]
  skip_before_filter :authenticate_user, :only => :index

  # GET /api/surveys
  def index
    @surveys = current_team.surveys.filter(params.slice(:guid))
  end

  # GET /api/surveys/1
  def show
  end

  # POST /api/surveys
  def create
    @survey = current_team.surveys.new(survey_params)
    respond_to do |format|
      if @survey.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/surveys/1
  def update
    respond_to do |format|
      if @survey.update(survey_params)
        format.json { render :show, status: :ok }
      else
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/surveys/1
  def destroy
    @survey.destroy
    render nothing: true
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_survey
    @survey ||= current_team.surveys.find(params[:id] || params[:guid])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def survey_params
    params.require(:survey).permit(:title, :description, :guid, :intro_id, :outro_id, :logo_path, :status, :scheduled, :scheduled_start, :scheduled_stop)
  end
end