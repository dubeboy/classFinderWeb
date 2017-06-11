class Api::V1::CommentsController < ApplicationController
  def index
  	@comments = Comment.where('post_id = ?', params[:network_post_id]).paginate(page: params[:page], per_page: 16).order(created_at: :desc)
  end

  def create
  	comment = Comment.new
  	comment.user = User.find(params[:user_id])
  	comment.post = Post.find(params[:network_post_id])
  	comment.com = params[:com] #the actual comment
  	@status = comment.save
  end
end
