class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @favorites = Favorite.where({ :user_id => @user.id})
    @favorite_dishes = []
    @favorites.each do |favorite|
      @favorite_dishes.push([Dish.find(favorite.dish_id),Venue.find(favorite.venue_id)])
    end

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.username = params[:username]

    if @user.save
      redirect_to "/users", :notice => "User created successfully."
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    @user.username = params[:username]

    if @user.save
      redirect_to "/users", :notice => "User updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy

    redirect_to "/users", :notice => "User deleted."
  end
end
