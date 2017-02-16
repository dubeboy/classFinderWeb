class AgentTexter < Textris::Base
  default :from => '+12025172570'

  def alert(trans)
    @trans = trans
    text :to => '+27641091553'
  end

  def notify(user)
    @user = user
    text :to => @user.contacts
  end

  def notify_seller(user)
    @user = user
    text :to => @user.contacts
  end
  def alert_accom(trans)
    @trans = trans
    text :to => '0641091553'
  end

  def notify_accom(user)
    @user = user
    text :to => @user.contacts
  end

end