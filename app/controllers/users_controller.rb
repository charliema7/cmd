class UsersController < ApplicationController
  before_action :admin_user, except: [:index, :show]
  def index
    @users = User.where.not(:id => current_user.id)
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @user = User.find(params[:id])
    @login_activities = LoginActivity.where(identity: @user.email).order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Successfully created User." 
      redirect_to root_path
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    
    if @user.update(user_params)
      flash[:notice] = "Successfully updated User."
      redirect_to root_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Successfully deleted User."
      redirect_back(fallback_location: root_path)
    end
  end 
  private

  # Confirms an admin user.
  def admin_user
    redirect_back(fallback_location: root_path) unless current_user.admin?
  end

  def user_params
     params.require(:user).permit(:email, :password, :password_confirmation, 
                                  :admin, :deleted_at, :title, :first_name, 
                                  :middle_name, :last_name, :cell_phone, 
                                  :secondary_phone, :fax, :street, :city, 
                                  :province, :postal, :country)
  end
end
