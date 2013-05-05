class VideoDecorator < Draper::Decorator
  delegate_all

  def rating
    if source
       source.reviews.average(:rating).to_f.round(1)
    else
       N/A
    end
  end
end
