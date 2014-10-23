class Users::RegistrationsController < Devise::RegistrationsController
  layout 'angular', :only => [:edit]
end
