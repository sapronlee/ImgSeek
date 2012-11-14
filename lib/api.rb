require 'grape'

class ImgSeek::API < Grape::API
  prefix 'api'
  format :json
    
  resource :pictures do
    get ':id' do
      Picture.find(params[:id])
    end
    
    post 'new' do
      @picture = Picture.new params[:picture]
      if @picture.save
        result = []
        @picture.search_pictures.each do |r|
          pic = Picture.find r.first
          puts pic.id
          result << pic.place
        end
        result.to_json
      else
        @picture.errors.messages.to_json
      end
    end
  end
end
