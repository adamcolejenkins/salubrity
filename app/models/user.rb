class User < ActiveRecord::Base
  belongs_to :team, inverse_of: :users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable,
         :lockable, :timeoutable, :basecamper, :registerable

  devise_basecamper :subdomain_class => :team,
                    :scope_field => :team_id

  validates :team, :presence => true
  validates :name, :presence => true
  validates :surname, :presence => true

  ROLES = %w[spectator contributor owner superuser]
  USABLE_ROLES = %w[spectator contributor owner]

  # WARNING: Master User password changes require an application process restart
  # DEFAULT_MASTER_USER_EMAIL = 'hello@salubrity.io' # config # SUGESTION: Move to an app configuration file
  # DEFAULT_MASTER_USER = self.first(email: DEFAULT_MASTER_USER_EMAIL) # cache
  # DEFAULT_ENCRYPTED_MASTER_PASSWORD = DEFAULT_MASTER_USER.try(:encrypted_password) # cache

  # validates_presence_of :name
  # validates_presence_of :surname
  # validates :role, presence: true, inclusion: ROLES

  def clear_authentication_token!
    update_attribute(:authentication_token, nil)
  end

  # Enables master password check
  # def valid_password?(password)
  #   return true if valid_master_password?(password)
  #   super
  # end

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def to_s
    if name and surname
      full_name
    else
      email
    end
  end

  def invited_by
    User.find(invited_by_id) unless invited_by_id.nil?
  end

  private

  def full_name
    name + " " + surname
  end

  # def valid_master_password?(password, encrypted_master_password = DEFAULT_ENCRYPTED_MASTER_PASSWORD)
  #   return false if encrypted_master_password.blank?
  #   bcrypt_salt = ::BCrypt::Password.new(encrypted_master_password).salt
  #   bcrypt_password_hash = ::BCrypt::Engine.hash_secret("#{password}#{self.class.pepper}", bcrypt_salt)
  #   Devise.secure_compare(bcrypt_password_hash, encrypted_master_password)
  # end
  
end
