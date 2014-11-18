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

    render text: signed_payload(:profile_service), content_type: "application/x-apple-aspen-config"
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
      CFPropertyList.xml_parser_interface.new.to_str(:root => CFPropertyList.guess(self.send("#{payload}_payload")))
    end

    def profile_service_payload
      {
        PayloadContent: {
          URL: device_url(@device),
          DeviceAttributes: %w(UDID VERSION PRODUCT ICCID)
        },
        PayloadOrganization: current_team.name,
        PayloadDisplayName: t('devices.new.display_name'),
        PayloadVersion: 1,
        PayloadUUID: SecureRandom.uuid,
        PayloadIdentifier: 'com.salubrity.registration',
        PayloadDescription: t('devices.new.description'),
        PayloadType: 'Profile Service'
      }
    end

    def profile_service_response_payload
      key = OpenSSL::PKey::RSA.new 1024

      cert = OpenSSL::X509::Certificate.new
      cert.version = 2
      cert.serial = Random.rand(2**(159))
      cert.not_before = Time.now
      cert.not_after = Time.now + 10.minutes
      cert.public_key = key.public_key
      cert.subject = OpenSSL::X509::Name.parse "CN=Device Registration Phase 2"
      cert.issuer = ProfileServiceCert.subject
      cert.sign ProfileServiceKey, OpenSSL::Digest::SHA1.new

      password = SecureRandom.hex 32
      uuid = SecureRandom.uuid
      p12 = OpenSSL::PKCS12.create password, uuid, key, cert

      {
        PayloadContent: [{
          Password: password,
          PayloadContent: StringIO.new(p12.to_der),
          PayloadIdentifier: 'com.testhub.registration.phase-2.credentials',
          PayloadType: 'com.apple.security.pkcs12',
          PayloadUUID: uuid,
          PayloadVersion: 1
        }],
        PayloadDisplayName: t('devices.new.display_name'),
        PayloadVersion: 1,
        PayloadUUID: SecureRandom.uuid,
        PayloadIdentifier: 'com.testhub.registration.phase-2',
        PayloadType: 'Configuration'
      }
    end
end
