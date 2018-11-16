class UsersController < ApplicationController
  respond_to :html, :json
def show
@user = User.find(params[:id])
end
def update
@user = User.find(params[:id])
params.permit!
@user.update_attributes(params[:user])
respond_with @user
end
end
