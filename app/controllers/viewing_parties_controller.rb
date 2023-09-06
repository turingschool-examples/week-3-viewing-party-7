class ViewingPartiesController < ApplicationController 
  # def new 
  #   if session[:user_id]
  #     @user = User.find(session[:user_id])
  #     @movie = Movie.find(params[:movie_id])
  #   else
  #     flash[:error] = "You must be logged in or registered to create a movie party."
  #     redirect_to movie_path(@movie.id, @user.id) but as a visitor there is no user id, soooooo what is this test trying to do?
  #   end
  # end

  def new 
    if current_user == nil
      flash[:error] = "You must be logged in or registered to create a movie party."
      redirect_to no_show_path
    end
    # user story 4 is broken and this is the fix for now
  end
end