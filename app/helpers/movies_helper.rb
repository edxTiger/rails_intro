module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def th_css_class(column)
    column == sorting_column ? 'hilite' : nil
  end

  def sortable(title, column, id)
    direction = (column == sorting_column && sort_direction == 'asc') ? 'desc' : 'asc'
    link_to title, {sort: column, direction: direction}, id: id
  end

  def sort_direction
    params[:direction] if %w[asc desc].include? params[:direction]
  end

  def sorting_column
    params[:sort] if Movie.column_names.include? params[:sort]
  end

  def legal_ratings
    params[:ratings]
    # if @all_ratings.include?(params[:ratings].)
  end

end
