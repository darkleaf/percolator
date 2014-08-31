class Api::V1::StarsController < ApplicationController
  def create
    SaveFavoritePageJob.new.async.perform star_params[:url]

    response.headers['Access-Control-Allow-Origin'] = '*'
    head :ok
  end

  private
  def star_params
    params.require(:star).permit(:url)
  end
end
