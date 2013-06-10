class Admin::UsersController < Admin::BaseController
  before_filter :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all(order: "email")
  end

  def new
    @user = User.new
  end

  def create
    admin = params[:user].delete(:admin) == "1"
    @user = User.new(params[:user])
    @user.admin = admin
    if @user.save
      flash[:notice] = "User has been created."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been created."
      render "new"
    end
  end

  def show
    
  end

  def edit
    
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    set_admin
    @user.skip_reconfirmation!
    if @user.update_attributes(params[:user])
      flash[:notice] = "User has been updated."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been updated."
      render "edit"
    end
    
  end

private
  def find_user
    @user = User.find(params[:id])
  end

  def set_admin
    @user.admin = params[:user][:admin] == "1"
    params[:user].delete(:admin)
  end
end
