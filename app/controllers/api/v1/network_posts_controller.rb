class Api::V1::NetworkPostsController < ApplicationController
  def create
    @status = false
    network = Network.find(params[:topic_id])
    post = Post.new
    post.network = network
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

  def like
  #  @likes = false
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

  def index
    @network_posts = Post.where('network_id=?', params[:network_id]).paginate(page: params[:page], per_page: 8).order(created_at: :desc)
    respond_to  do |format|
      format.json
    end
  end
end
