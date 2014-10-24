class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, only: [:edit, :update, :destroy]
  layout 'angular'

  def index
    @users = @current_team.users.invitation_accepted
    @pending = @current_team.users.invitation_not_accepted
  end

  def edit

  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, alert: @user.errors }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = @current_team.users.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:role)
  end
end
