class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]


  def index
    @users = User.not_admins
    @all_users = User.all
  end

  def show
  #  @user = User.find_by!(username: params[:id])
    @reviews = @user.reviews
    @favourite_movies = @user.favourite_movies
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thanks for signing up!"
    else
      render :new
    end
  end

  def edit
#    @user = User.find(params[:id])
  end

  def update
#    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "Account successfully updated!"
    else
      render :edit
    end
  end

  def destroy
  #  @user = User.find(params[:id])
    @user.destroy
    session[:user_id] = nil if current_user_admin?
    redirect_to root_url, alert: "Account successfully deleted!"
  end

private
  def set_user
    @user = User.find_by!(username: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                          :password_confirmation, :username)
  end

  def require_correct_user
  #  @user = User.find_by!(username: params[:id])
    redirect_to root_url unless current_user?(@user) || current_user_admin?
  end
end
