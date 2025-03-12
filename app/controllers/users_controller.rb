class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end
  def change_password
  end
  def update_password
    @user = current_user

    if @user.update(password_params)
      bypass_sign_in(@user)  # Keep the user signed in after updating password
      flash[:notice] = "Password successfully updated"
      redirect_to root_path
    else
      flash[:alert] = "Error updating password"
      render :change_password
    end
  end

  private

  def password_params
    params.permit(:password, :password_confirmation)
  end
end
