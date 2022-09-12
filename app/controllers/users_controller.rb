class UsersController < ApplicationController
  
  def index
  end

  def new 
  end  
  
  def create
  end  

  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
   
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :roles)
    end
end