class Api::V1::RefsController < ApplicationController
  def share #todo: post method
    token = params[:token]
    accom_id = params[:accom_id]

    u = User.find_by_token(token)
    a = Accommodation.find(accom_id)

    finderShare = UserAccommodationShare
                      .new(accom_id: a.id,
                           user_token: u.id)

    finderShare.save
    #todo: should show preview on social media
  end


  #
  def index

  end

  def getSharesForUser

  end
end
