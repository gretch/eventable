class CommentsController < ApplicationController
  def create
    @idea = Idea.find(params[:comment][:idea_id])
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.author_name = current_user.user_name
    @idea.comments << @comment
  
    if @comment.save
      flash[:notice] = 'Comment successfully posted.'
    else
      flash[:notice] = 'Error trying to save your comment.'
    end

    respond_to do |format|
      format.html { redirect_to idea_path(@idea)}
    end
  end
end
