class ConfigController < ApplicationController
  layout 'config'

  def index
    @team = current_team
  end
end
