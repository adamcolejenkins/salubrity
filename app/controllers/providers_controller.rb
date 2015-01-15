class ProvidersController < ConfigController
  authorize_resource
  before_action :set_provider, only: [:show, :edit, :update, :destroy, :archive]

  # GET /providers
  # GET /providers.json
  def index
    @providers = current_team.providers.all
  end

  # GET /providers/1
  # GET /providers/1.json
  def show
  end

  # GET /providers/new
  def new
    @provider = current_team.providers.new
  end

  # GET /providers/1/edit
  def edit
  end

  # POST /providers
  # POST /providers.json
  def create
    @provider = current_team.providers.new(provider_params)

    respond_to do |format|
      if @provider.save
        format.html { redirect_to providers_url, notice: 'Provider was successfully created.' }
        format.json { render :show, status: :created, location: @provider }
      else
        format.html { render :new }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /providers/1
  # PATCH/PUT /providers/1.json
  def update
    respond_to do |format|
      if @provider.update(provider_params)
        format.html { redirect_to providers_url, notice: 'Provider was successfully updated.' }
        format.json { render :show, status: :ok, location: @provider }
      else
        format.html { render :edit }
        format.json { render json: @provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.json
  def destroy
    @provider.really_destroy!
    respond_to do |format|
      format.html { redirect_to archived_providers_url, notice: 'Provider was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /providers/archived
  def archived
    @providers = current_team.providers.only_deleted
  end

  # GET /providers/1/restore
  def restore
    Provider.restore(params[:id], recursive: true)

    respond_to do |format|
      format.html { redirect_to archived_providers_url, notice: 'Provider was successfully restored.' }
      format.json { render :show, status: :ok }
    end
  end

  # DELETE /providers/1/delete
  # DELETE /providers/1/delete.json
  def archive
    @provider.destroy
    respond_to do |format|
      format.html { redirect_to providers_url, notice: 'Provider was successfully archived.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provider = current_team.providers.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_params
      params.require(:provider).permit(:name, :surname, :credential, :clinic_id, :clinic, :team_id, :position, :email, :phone, :photo)
    end

end
