class Picture < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  
  belongs_to :imageable, polymorphic: true

  mount_uploader :content, ScreenshotUploader

  validates :content, presence: true

  def content_url
    picture_path(self)
  end

  def content_thumb_url
    thumb_picture_path(self)
  end

end
