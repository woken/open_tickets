class PicturesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_picture, only: [:show, :thumb]

  def show
    send_file @picture.content.path, type: @picture.content.file.content_type, disposition: 'inline'
  end

  def thumb
    send_file @picture.content.thumb.path, type: @picture.content.file.content_type, disposition: 'inline'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find_by(id: params[:id])
      render text: '404', status: 404, layout: 'application' unless @picture
    end
end
