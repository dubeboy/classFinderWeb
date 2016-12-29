class SuperUserController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all.paginate(page: params[:page], per_page: 25).order(created_at: :desc) if current_user.king?
  end
  
  def do
    user_id = params['user_id']
    u = User.find(user_id)
    runner = params['runner'] 
    if runner == true
      k = " Runner "
      if u.runner? == true
        u.runner = false
        b = " Removed  "
      else
        u.runner = true 
         b = " Made  "      
      end
    else
      k = " Host "
      if u.verified? == true
       u.verified = false
       b = " Removed  "

      else
        u.verified = true
        b = " Made  "
      end
    end
    redirect_to 'super_user/index', notice: "You have "+ b + u.name + " from " + k
  end 
 
end
