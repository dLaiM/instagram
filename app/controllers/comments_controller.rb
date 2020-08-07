class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
	  @comment = Comment.new(comment_params)
	  @post = @comment.post
	  # binding.pry
	  @comment.user_id = current_user.id
	  @comment.post_id = params[:post_id]
	  # binding.pry
	  if @comment.save
		  redirect_to posts_path
	  end
  end
  def destroy
	  comment = Comment.find_by(id: params[:id])
	  @post = comment.post
	  if comment.destroy
		  redirect_to posts_path
	  end
  end
  private
  	def comment_params
	  	# binding.pry
		params.require(:comment).permit(:user_id, :post_id, :comment)
	end

end
