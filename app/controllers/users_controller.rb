class UsersController < ApplicationController
  before_filter :authenticate_user!
  layout 'angular'

  def index
    @users = User.all
  end
end
