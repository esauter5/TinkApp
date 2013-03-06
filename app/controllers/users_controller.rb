class UsersController < ApplicationController
  before_filter :authenticate_user!

  def register_device
    @user = current_user
  	did = params[:deviceID]
  	@user.device_id = did

  	respond_to do |format|
      if @user.save
  		  format.html
  		  format.json { render json: @user }
      end
  	end
  end

  def delete_device
    @user = current_user
    @user.device_id = ""

    respond_to do |format|
      if @user.save
        format.html
        format.json { render json: @user }
      end
    end
  end

  def index
  	@users = User.all

  	respond_to do |format|
  		format.html
  		format.json
  	end
  end
end
