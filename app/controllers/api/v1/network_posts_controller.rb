class Api::V1::NetworkPostsController < ApplicationController
  def create
    network = Network.find(params[:network_id])
    post = Post.new
    post.network = network
    post.name = params[:name]
    post.description = params[:desc]
    params[:images].each { |image|
      post.pictures.create(image: image)
    }
    @status = post.save
  end

  def index

  end
end
