require 'grape'

class ImgSeek::API < Grape::API
  prefix 'api'
  format :json
    
  resource :pictures do
    get ':id' do
      Picture.find(params[:id]).to_json
    end
    
    post 'new' do
      @picture = Picture.new params[:picture]
      if @picture.save
        p = @picture.find_image_to_imgseek
        if p.nil?
          []
        else
          p.place.to_json
        end
      end
    end
  end
  
  resource :places do
    get ':id' do
      Place.find(params[:id]).to_json
    end
  end
end
