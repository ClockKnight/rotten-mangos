module MoviesHelper

  def formatted_date(date)
    date.strftime("%b %d, %Y")
  end

  def image_url(movie)
    if movie.image.nil?
      movie.image.url
    else
      movie.poster_image_url
    end
  end

end
