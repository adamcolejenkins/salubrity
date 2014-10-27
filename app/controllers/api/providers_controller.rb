class Api::ProvidersController < Api::BaseController
  before_action :set_provider, only: [:show, :update, :destroy]

  # GET /providers
  # GET /providers.json
  def index
    @providers = clinic.providers.all
  end

  # GET /providers/1
  # GET /providers/1.json
  def show
  end

  # POST /providers
  # POST /providers.json
  def create
    @provider = clinic.providers.new(provider_params)
    
    respond_to do |format|
      if @provider.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /providers/1
  # PATCH/PUT /providers/1.json
  def update
    respond_to do |format|
      if @provider.update(provider_params)
        format.json { render :show, status: :ok }
      else
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.json
  def destroy
    @provider.destroy
    render nothing: true
  end

  private

    def survey
      @survey ||= current_team.surveys.find(params[:survey_id])
    end

    def clinic
      @clinic ||= survey.clinics.find(params[:clinic_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provider ||= clinic.providers.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_params
      params.require(:provider).permit(:name, :position, :email, :phone, :clinic, :photo)
    end
end
