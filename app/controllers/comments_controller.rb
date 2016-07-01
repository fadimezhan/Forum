class CommentsController < ApplicationController
  before_action :find_comment, only: [:destroy,:edit,:update]
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id=current_user.id if current_user

    if @comment.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def destroy
    @comment.destroy

    redirect_to @post
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  private
  def find_comment
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
