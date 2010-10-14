class UsersController < ApplicationController
  respond_to :html
  before_filter :current_user, :only => [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.save and flash[:notice] = "User created successfully."
    respond_with @user, :location => :users
  end

  def edit
  end

  def update
    if @user.update_with_password(params[:user])
      flash[:notice] = "User updated successfully."
    end
    respond_with @user, :location => :users
  end

  def destroy
    if @user.destroy
      flash[:notice] = "User removed successfully."
    else
      flash[:error] = "Something went wrong and the user was not destroyed. Please try again."
    end
    respond_with @user
  end

  protected

  def current_user
    @user = User.find(params[:id])
  end
  
end
