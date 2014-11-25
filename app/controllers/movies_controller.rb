class MoviesController < ApplicationController

  def index
    @all_ratings = Movie.pluck(:rating).uniq.sort
    @checked_ratings = @all_ratings if @checked_ratings.nil?

    session[:sort] = params[:sort] if !params[:sort].nil? && session[:sort] != params[:sort]
    session[:direction] = params[:direction] if !params[:direction].nil? && session[:direction] != params[:direction]
    session[:ratings] = params[:ratings] if !params[:ratings].nil? && session[:ratings] != params[:ratings]

    redirect_to movies_path(sort: session[:sort], direction: session[:direction], ratings: session[:ratings]) if
        params[:sort].nil? && params[:ratings].nil? && params[:direction].nil? && params[:direction].nil? &&
            (!session[:sort].nil? || !session[:ratings].nil?)

    @sort = session[:sort]
    @direction = session[:direction]
    @ratings = session[:ratings]

    session[:ratings].nil? ? ratings = Movie.pluck(:rating).uniq.sort : ratings = @ratings.keys
    @checked_ratings = ratings

    (@sort.nil?) ?
      @movies = Movie.where(rating: ratings) :
      @movies = Movie.where(rating: ratings).order("#{params[:sort]} #{params[:direction]}")
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
