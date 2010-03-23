class UsersController < ApplicationController

  before_filter :load_user, :only => [:show, :edit, :update, :destroy]

  def index
    @users = User.all

    respond_to do |format|
      format.html
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'Signup successfull!'
        format.html { redirect_to root_path }
      else
        format.html { render :action => :new }
      end
    end
  end

  def update

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Successfully updated.'
        format.html { redirect_to(@user) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    if @user.update_attribute(:deleted_at, Time.now)
      flash[:notice] = "Account successfully deleted."
    else
      flash[:error] = "Error trying to delete account."
    end

    respond_to do |format|
      format.html { redirect_to(users_url) }
    end
  end

  private
    def load_user
      @user = User.find_by_param(params[:id])
    end
end
