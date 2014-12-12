class ClinicsController < ConfigController
  load_and_authorize_resource
  before_action :set_clinic, only: [:show, :edit, :update, :destroy]

  # GET /clinics
  # GET /clinics.json
  def index
    @clinics = current_team.clinics.all
  end

  # GET /clinics/1
  # GET /clinics/1.json
  def show
  end

  # GET /clinics/new
  def new
    @clinic = current_team.clinics.new
  end

  # GET /clinics/1/edit
  def edit
  end

  # POST /clinics
  # POST /clinics.json
  def create
    @clinic = current_team.clinics.new(clinic_params)

    respond_to do |format|
      if @clinic.save
        format.html { redirect_to clinics_url, notice: 'Clinic was successfully created.' }
        format.json { render :show, status: :created, location: @clinic }
      else
        format.html { render :new }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinics/1
  # PATCH/PUT /clinics/1.json
  def update
    respond_to do |format|
      if @clinic.update(clinic_params)
        format.html { redirect_to clinics_url, notice: 'Clinic was successfully updated.' }
        format.json { render :show, status: :ok, location: @clinic }
      else
        format.html { render :edit }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinics/1
  # DELETE /clinics/1.json
  def destroy
    @clinic.destroy
    respond_to do |format|
      format.html { redirect_to clinics_url, notice: 'Clinic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /clinics/archived
  def archived
    @clinics = current_team.clinics.only_deleted
  end

  # GET /clinics/1/restore
  def restore
    Clinic.restore(params[:id], recursive: true)

    respond_to do |format|
      format.html { redirect_to archived_clinics_url, notice: 'Clinic was successfully restored.' }
      format.json { render :show, status: :ok }
    end
  end

  # DELETE /clinics/1/delete
  # DELETE /clinics/1/delete.json
  def archive
    @clinic = current_team.clinics.only_deleted.find(params[:id])
    @clinic.destroy
    respond_to do |format|
      format.html { redirect_to clinics_url, notice: 'Clinic was successfully archived.' }
      format.json { head :no_content }
    end
  end

  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_clinic
      @clinic = current_team.clinics.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clinic_params
      params.require(:clinic).permit(:title, :guid, :team, :survey, :survey_id, :address, :address2, :city, :state, :zip, :phone, :background)
    end

end
