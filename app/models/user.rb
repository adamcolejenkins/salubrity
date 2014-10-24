class User < ActiveRecord::Base
  belongs_to :team
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :basecamper

  devise_basecamper :subdomain_class => :team,
                    :scope_field => :team_id

  # validates :team, :presence => true

  ROLES = %w[superuser owner contributor spectator]

  # validates_presence_of :name
  # validates_presence_of :surname
  # validates :role, presence: true, inclusion: ROLES

  def clear_authentication_token!
    update_attribute(:authentication_token, nil)
  end

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  private
  
end
