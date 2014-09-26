class Api::FieldsController < Api::BaseController
  before_action :set_field, only: [:show, :update, :destroy]

  # GET /api/surveys/1/fields
  def index
    render json: survey.fields
  end

  # GET /api/surveys/1/fields/1
  def show
    render json: @field
  end

  # POST /api/surveys/1/fields
  def create
    @field = survey.fields.create!(safe_params)
    render json: @field, status: :created
  end

  # PATCH/PUT /api/surveys/1/fields/1
  def update
    @field.update_attributes(safe_params)
    render json: @field, status: :ok
  end

  # DELETE /api/surveys/1/fields/1
  def destroy
    @field.destroy
    render nothing: true
  end

  private

  def survey
    @survey ||= Survey.find(params[:survey_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_field
    @field ||= survey.fields.find(params[:id] || params[:field_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def safe_params
    params.require(:field).permit(:survey_id, :label, :field_type, :field_size, :layout, :display_as, :instructions, :range_min, :range_max, :increment, :required, :visibility, :predefined_value, :priority, :target_priority)
  end
end

# field_choices_attributes: [:field_id, :key, :label, :priority],