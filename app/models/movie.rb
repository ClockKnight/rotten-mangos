class Movie < ActiveRecord::Base

  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past
  validate :has_an_image

  mount_uploader :image, ImageUploader

  def review_average
    if reviews.size == 0
      "Unrated"
    else
      "#{reviews.sum(:rating_out_of_ten)/reviews.size}/10"
    end
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

  def has_an_image
    # if !image.present? && !poster_image_url.present?
    unless [image?, poster_image_url?].include?(true)
      errors.add :base, 'You need to include an image from file or an image url.'
    end
  end

end
