class SuperUserController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all.paginate(page: params[:page], per_page: 50).order(created_at: :desc) if current_user.king?
    @trans = Transaction.all
  end
  
  def do
    user_id = params['user_id']
    u = User.find(user_id)
    runner = params['runner'] 
    if runner == "true"
      k = " from being a Runner "
      if u.runner? == true
        u.runner = false
        
        b = " Removed  "
      else
        u.runner = true 
         b = " Made  "      
      end
    else
      k = " from being a Host "
      if u.verified? == true
       u.verified = false
       b = " Removed  "

      else
        u.verified = true
        b = " Made  "
      end
    end

      if u.save!
      flash[:notice] = "You have "+ b + u.name + k
    end
    redirect_to :back
   
  end 
 
end
