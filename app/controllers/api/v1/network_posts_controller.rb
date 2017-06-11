class Api::V1::NetworkPostsController < ApplicationController
  #this is a post in a category / topic / post(this!)
  def create
    @status = false
    is_event = params[:is_event] == true ? true : false
    if (is_event?)
      network = 0 # the first one is an event in each of the
    else
      network = Network.find(params[:topic_id])
    end
    post = Post.new
    post.network = network
    post.is_event = is_event # if its true its an event yo!
    post.name = params[:name]
    post.description = params[:desc]
    post.user = User.find(params[:user_id])
    if(post.save!)
      if(!params[:images].nil?)
        params[:images].each { |image|
          post.pictures.create(image: image)
        }
      end
      @status = true #TODO: please make sure that this will reflect when the images failed to save!
    end
  end

#TODO: this button is toggle button
  def like
  #  @likes = false
   #TODO : sjould be put in a before action yoh!
    post = Post.find(params[:network_post_id])
    user = User.find(params[:user_id])
    @likes = Like.post_like(post, user)
    if @likes
      post.likes.nil? ? post.likes = 1 : post.likes += 1
      @likes = post.save!
    end
     respond_to  do |format|
      format.json
    end
  end

def attend_event
  post = Post.find(params[:network_post_id])
  user = User.find(params[:user_id])

  attend = AttendEvent.new
  attend.post_id


end


  def index
    @network_posts = Post.where('network_id=?', params[:topic_id]).paginate(page: params[:page], per_page: 16).order(created_at: :desc)
    respond_to  do |format|
      format.json
    end
  end
end
