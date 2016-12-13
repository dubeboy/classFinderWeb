class ProfilesController < ApplicationController
  before_action :authenticate_user!
  def index

  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      puts current_user
      @profile.user = current_user
      current_user.profile = @profile
      current_user.save
      flash[:success] = 'Your account has been created succesfully'
      redirect_to profiles_path
    else
      render 'new'
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  private
    def profile_params
      params.require(:profile).permit!
    end



end
