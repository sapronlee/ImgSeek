class Api2::PlacesController < ApplicationController
  
  def audio
    @place = Place.find params[:id]
    send_file @place.audio.path, :type => "audio/mp3", :filename => "audio.mp3"
  end
end
