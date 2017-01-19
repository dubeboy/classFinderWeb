class HostsController < ApplicationController

  before_action :authenticate_user!, only: [:choose_user_type]

  def index
  end

  def choose_user_type
      current_user.runner = true
      if current_user.verified
        redirect_to root_path, notice: 'You can not be runner and a Host as you should ask super user to remove you from Hosts lists'
      else
          current_user.save!(:validate => false)
          redirect_to edit_user_path(current_user), notice: 'You are now a runner. Now please add your running time and location to get customers and some bucks!'
      end
  end

  def user_type
     
  end 
end
