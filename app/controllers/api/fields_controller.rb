class Api::FieldsController < Api::BaseController
  before_action :set_field, only: [:show, :update, :destroy]

  # GET /api/surveys/1/fields
  def index
    @fields = survey.fields.all
  end

  # GET /api/surveys/1/fields/1
  def show
  end

  # POST /api/surveys/1/fields
  def create
    @field = survey.fields.new(field_params)

    respond_to do |format|
      if @field.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/surveys/1/fields/1
  def update
    respond_to do |format|
      if @field.update(field_params)
        format.json { render :show, status: :ok }
      else
        format.json { render json: @field.errors, status: :unprocessable_entity }
      end
    end
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
  def field_params
    params.require(:field).permit(:survey_id, :label, :context, :field_size, :layout, :display_as, :instructions, :range_min, :range_max, :increment, :required, :visibility, :predefined_value, :priority, :target_priority, :attachment_type, :attachment_url, :button_label, :button_mode, :button_url)
  end
end

# field_choices_attributes: [:field_id, :key, :label, :priority],