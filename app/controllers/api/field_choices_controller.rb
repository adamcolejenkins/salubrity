class Api::FieldChoicesController < Api::BaseController
  before_action :set_field_choice, only: [:show, :update, :destroy]

  # GET /api/surveys/1/fields/1/choices
  def index
    render json: field.field_choices
  end

  # GET /api/surveys/1/fields/1/choices/1
  def show
    render json: @field_choice
  end

  # POST /api/surveys/1/fields/1/choices
  def create
    @field_choice = field.field_choices.create!(safe_params)
    render json: @field_choice, status: :created
  end

  # PATCH/PUT /api/surveys/1/fields/1/choices/1
  def update
    @field_choice.update_attributes(safe_params)
    render json: @field, status: :ok
  end

  # DELETE /api/surveys/1/fields/1/choices/1
  def destroy
    @field_choice.destroy
    render nothing: true
  end

  private

  def field
    @field ||= Field.find(params[:field_id] || params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_field_choice
    @field_choice ||= field.field_choices.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def safe_params
    params.require(:field_choice).permit(:field_id, :label, :key, :priority)
  end
end