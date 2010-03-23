class IdeasController < ApplicationController

  before_filter :load_idea, :only => [:show, :edit, :update, :destroy]
  def index
    @ideas = Idea.all.paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @ideas }
    end
  end

  def show
    @comment = Comment.new
    @comments = @idea.comments

    respond_to do |format|
      format.html
    end
  end

  def new
    @idea = Idea.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @idea = Idea.new(params[:idea])
    @idea.author = User.find_by_param(@idea.author_name) #Yes the user might be in the system already

    respond_to do |format|
      if @idea.save
        flash[:notice] = 'Your Idea was successfully posted.'
        format.html { redirect_to root_path }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    respond_to do |format|
      if @idea.update_attributes(params[:idea])
        flash[:notice] = 'Your Idea was successfully updated.'
        format.html { redirect_to root_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    if @idea.update_attribute(:deleted_at, Time.now)
      flash[:notice] = 'Idea was successfully deleted.'
    else
      flash[:notice] = 'We have trouble deleting that idea.'
    end
 
    respond_to do |format|
      format.html { redirect_to(ideas_url) }
    end
  end

  private

    def load_idea
      @idea = Idea.find(params[:id])
    end
end
