class HostsController < ApplicationController

  before_action :authenticate_user!, only: [:choose_user_type]

  def index
  end

  def choose_user_type
    if current_user.verified
      redirect_to root_path, notice: 'You can not be runner and a Host as you should ask super user to remove you from Hosts lists'
    else
      current_user.runner = true
      current_user.save!(:validate => false)
      redirect_to edit_user_path(current_user),
                  notice: 'You are now a Runner. As a Runner you are expected to take clients to view rooms around
                                an area you are familiar with.Select an area around which you are available to take clients to view rooms.'
    end
  end

  def user_type

  end
end
