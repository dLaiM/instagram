class PostsController < ApplicationController
	before_action :authenticate_user!
	def show
		@post = Post.find(params[:id])
		@comments = @post.comments
		@comment = Comment.new
	end
	def new
		 @post = Post.new
		 @post.photos.build
	end
	def create
		@post = Post.new(post_params)
		if @post.photos.present?
			@post.save
			flash[:notice] = "投稿が保存されました"
			redirect_to posts_path
		else
			flash[:alert] = "投稿に失敗しました"
			redirect_to root_path
		end
	end
	def index
		@posts = Post.limit(10).includes(:photos, :user).order('created_at DESC')
		@post = Post.new
	end

	private
		def post_params
			params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
		end
end
