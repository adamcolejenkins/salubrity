class InstallsController < ApplicationController
  before_action :set_clinics, only: [:new, :create, :edit, :update]
  before_action :set_surveys, only: [:new, :create, :edit, :update]

  # GET /installs
  # GET /installs.json
  def index
  end

  # GET /installs/1
  # GET /installs/1.json
  def show
  end

  # GET /installs/new
  def new
    @device = Device.new
  end

  # GET /installs/1/edit
  def edit
  end

  # POST /installs
  # POST /installs.json
  def create
    @device = current_team.devices.create!(device_params)
    @device.os = get_os
    @device.os_version = get_os_version
    @device.save

    send_data signed_payload(:profile_service).to_str, content_type: :mobileconfig
  end

  # PATCH/PUT /installs/1
  # PATCH/PUT /installs/1.json
  def update
    
  end

  # DELETE /installs/1
  # DELETE /installs/1.json
  def destroy
    
  end

  private

    def set_surveys
      @surveys = current_team.surveys.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_clinics
      @clinics = current_team.clinics.all
    end

    def get_os
      
    end

    def get_os_version
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:survey_id, :clinic_id, :access_passcode, :restriction_passcode, :guided_access_passcode, :internal_identifier)
    end

    def signed_payload(payload)
      # CFPropertyList.xml_parser_interface.new.to_str(:root => CFPropertyList.guess(self.send("#{payload}_payload")))
      OpenSSL::PKCS7::sign ServerCert,
                           ServerKey,
                           CFPropertyList.xml_parser_interface.new.to_str(:root => CFPropertyList.guess(self.send("#{payload}_payload"))),
                           ServerChain,
                           OpenSSL::PKCS7::BINARY
    end

    def profile_service_payload
      {
        PayloadContent: {
          URL: device_url(@device),
          DeviceAttributes: %w(UDID VERSION PRODUCT SERIAL),
          Challenge: @device.access_passcode
        },
        PayloadOrganization: current_team.name,
        PayloadDisplayName: t('devices.new.display_name'),
        PayloadVersion: 1,
        PayloadUUID: SecureRandom.uuid,
        PayloadIdentifier: 'com.salubrity.profile-service',
        PayloadDescription: t('devices.new.description'),
        PayloadType: 'Profile Service'
      }
    end
end
