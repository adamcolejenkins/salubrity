class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = %w[superuser owner contibutor spectator]

  def clear_authentication_token!
    update_attribute(:authentication_token, nil)
  end
end
