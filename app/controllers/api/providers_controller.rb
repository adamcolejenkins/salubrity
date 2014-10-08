class Api::ProvidersController < Api::BaseController
  before_action :set_provider, only: [:show, :update, :destroy]

  # GET /providers
  # GET /providers.json
  def index
    render json: clinic.providers
  end

  # GET /providers/1
  # GET /providers/1.json
  def show
    render json: @provider
  end

  # POST /providers
  # POST /providers.json
  def create
    @provider = clinic.providers.create!(provider_params)
    render json: @provider, status: :created
  end

  # PATCH/PUT /providers/1
  # PATCH/PUT /providers/1.json
  def update
    @provider.update_attributes(provider_params)
    render json: @provider, status: :ok
  end

  # DELETE /providers/1
  # DELETE /providers/1.json
  def destroy
    @provider.destroy
    render nothing: true
  end

  private

    def clinic
      @clinic ||= Clinic.find(params[:clinic_id])
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
