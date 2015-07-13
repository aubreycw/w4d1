class UsersController < ApplicationController

  def index
    render json: User.all
  end

  def show
    begin
      user = User.find(params[:id])
      render json: user
    rescue ActiveRecord::RecordNotFound
      render text: "Could not find id"
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render(
        json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def update
    if User.update(params[:id], user_params)
      render json: User.find(params[:id])
    else
      render(
        json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    if User.exists?(params[:id])
      User.delete(params[:id])
      render json: User.all
    else
      render text: "could not delete"
    end
  end

  def user_params
    params[:user].permit(:name, :email)
  end


end
