class MoviesController < ApplicationController

  def index
    session[:sort] = params[:sort] unless params[:sort].nil?
    session[:direction] = params[:direction] unless params[:direction].nil?
    
    @all_ratings = Movie.pluck(:rating).uniq.sort
    @checked_ratings = []
    params[:ratings].nil? ? @checked_ratings = @all_ratings : params[:ratings].each_key { |k| @checked_ratings << k }
    @movies = Movie.where(rating: @checked_ratings).order "#{params[:sort]} #{params[:direction]}"
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
