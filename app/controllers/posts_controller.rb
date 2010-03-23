class PostsController < ApplicationController

  before_filter :load_post, :only => [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all.paginate(:page => params[:page], :per_page => 20)
    
    @month = params[:month].blank? Time.now.month : params[:month].to_i
    @year = params[:year].blank? Time.now.year : params[:year].to_i
    @shown_month = Date.civil(@year, @month)
    @event_strips = Event.event_strips_for_month(@shown_month)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @posts }
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments

    respond_to do |format|
      format.html
    end
  end

  def new
    @post = post.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @post = Post.new(params[:post])
    @post.author = User.find_by_param(@post.author_name) #Yes the user might be in the system already

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Your post was successfully posted.'
        format.html { redirect_to root_path }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Your post was successfully updated.'
        format.html { redirect_to root_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    if @post.update_attribute(:deleted_at, Time.now)
      flash[:notice] = 'post was successfully deleted.'
    else
      flash[:notice] = 'We have trouble deleting that post.'
    end
 
    respond_to do |format|
      format.html { redirect_to(posts_url) }
    end
  end

  private

    def load_post
      @post = Post.find(params[:id])
    end
end
