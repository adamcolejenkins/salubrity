class Api::ClinicsController < Api::BaseController
  before_action :set_clinic, only: [:show, :update, :destroy]

  # GET /clinics
  # GET /clinics.json
  def index
    @clinics = Clinic.all
  end

  # GET /clinics/1
  # GET /clinics/1.json
  def show
  end

  # POST /clinics
  # POST /clinics.json
  def create
    @clinic = Clinic.new(clinic_params)
    
    respond_to do |format|
      if @clinic.save
        format.json { render :show, status: :created }
      else
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinics/1
  # PATCH/PUT /clinics/1.json
  def update
    respond_to do |format|
      if @clinic.update(clinic_params)
        format.json { render :show, status: :ok }
      else
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinics/1
  # DELETE /clinics/1.json
  def destroy
    @clinic.destroy
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinic
      @clinic ||= Clinic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clinic_params
      params.require(:clinic).permit(:title, :survey, :address, :address2, :city, :state, :zip, :phone, :guid)
    end
end
