class SuperUserController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all.paginate(page: params[:page], per_page: 150).order(created_at: :desc) if current_user.king?
    @trans = Transaction.all
  end
  

  #TODO: protect this please it not safe


  def do
    user_id = params['user_id']
    u = User.find(user_id)
    runner = params['runner'] 
    if runner == "true"
      k = ' from being a Accommodation Assistant  '
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

      if u.save!(:validate => false)
      flash[:notice] = "You have "+ b + u.name + k
    end
    redirect_to :back
   
  end


  # //protect
  def change_runner
    runner_id = params['/super_user'][:runner_id]
    transaction_id = params['/super_user'][:trans_id]
    t = Transaction.find(transaction_id)
    t.runner_id = runner_id
    t.save!
    redirect_to
  end
 
end
