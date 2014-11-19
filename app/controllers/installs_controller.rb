class InstallsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:update]
  skip_before_filter :verify_authenticity_token, :only => [:update]

  before_action :set_clinics, only: [:new, :create]
  before_action :set_surveys, only: [:new, :create]

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

    # render plist: profile_service_payload, content_type: "application/x-apple-aspen-config"
    send_data signed_payload(:profile_service).to_der, content_type: "application/x-apple-aspen-config"
  end

  # PATCH/PUT /installs/1
  # PATCH/PUT /installs/1.json
  def update
    profile_service_response = OpenSSL::PKCS7.new request.raw_post
    profile_service_response.verify profile_service_response.certificates, ProfileServiceStore, nil, OpenSSL::PKCS7::NOINTERN | OpenSSL::PKCS7::NOCHAIN
    profile_service_attributes = CFPropertyList::List.new(:data => profile_service_response.data).value



    render text: "OK"
    @device = Device.find(params[:id])
    existing_device = Device.where(:udid => profile_service_attributes.value['UDID'].value).first
    if existing_device && existing_device != @device
      @device.try :destroy
      @device = existing_device
    end

    render plist: profile_service_payload, content_type: :mobileconfig
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
      OpenSSL::PKCS7::sign ProfileServiceCert,
                         ProfileServiceKey,
                         CFPropertyList.xml_parser_interface.new.to_str(:root => CFPropertyList.guess(self.send("#{payload}_payload"))),
                         nil,
                         OpenSSL::PKCS7::BINARY
    end

    def profile_service_payload
      {
        PayloadContent: {
          URL: device_url(@device),
          DeviceAttributes: %w(UDID VERSION PRODUCT SERIAL)
          # Challenge: @device.access_passcode
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
