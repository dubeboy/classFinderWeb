class SuperUserController < ApplicationController
  def index
    @users = User.all
  end
end
