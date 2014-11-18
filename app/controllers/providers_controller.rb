class ProvidersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_provider, only: [:show, :edit, :update, :destroy, :chart]
  layout 'angular'

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
    @provider.destroy
    respond_to do |format|
      format.html { redirect_to providers_url, notice: 'Provider was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def chart
    self.send("#{params[:type]}_chart")
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      @provider = current_team.providers.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_params
      params.require(:provider).permit(:name, :surname, :credential, :clinic_id, :team_id, :position, :email, :phone, :photo)
    end

    # CHARTS
    def responses_chart
      render json: @provider.responses.group_by_day(:created_at, format: "%A, %B %e").count
    end

    def timing_chart
      render json: @provider.responses.daily_avg_time
    end

    def multiple_choice_chart
      @field = Field.find(params[:field_id])
      render json: @provider.data_for(:multiple_choice_field, field: @field)
    end

    def scale_chart
      @field = Field.find(params[:field_id])
      render "fields/_scale.json.jbuilder", locals: { field: @field, resource: @provider }
    end
end
