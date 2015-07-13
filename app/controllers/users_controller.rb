class UsersController < ApplicationController

  def index
    render text: "I'm in the index action!"
  end

  def show
    render json: {'a' => 1}
  end
end
