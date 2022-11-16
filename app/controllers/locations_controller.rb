class LocationsController < ApplicationController
  def create
    previous_lat = session[:lat]

    session[:lat] = params[:lat].to_f
    session[:lng] = params[:lng].to_f
    # session[:map] = params[:map]

    if previous_lat.nil? && session[:lat].present?
      redirect_back fallback_location: root_path
    end
  end
end
