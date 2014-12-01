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

  # validates_presence_of :name
  # validates_presence_of :surname
  # validates :role, presence: true, inclusion: ROLES

  def clear_authentication_token!
    update_attribute(:authentication_token, nil)
  end

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def to_s
    name + " " + surname
  end

  private
  
end
