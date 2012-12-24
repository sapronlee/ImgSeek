class Api::V3::PlacesController < Api::V3::ApplicationController
  
  def show
    @place = Place.find params[:id]
    respond_with @place
  end
  
  def search
    @places = Place.search_by_name params[:name]
    render :json => @places
  end
  
  def mp3
    @place = Place.find params[:id]
    send_file @place.audio.path, :type => "audio/mp3", :filename => "#{@place.audio.file.filename}"
  end
  
end
