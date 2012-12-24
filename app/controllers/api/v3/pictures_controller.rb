class Api::V3::PicturesController < Api::V3::ApplicationController
  
  def create
    param = { :scenic_id => params[:scenic], :image => params[:image] }
    upload_time = Time.now.to_s
    @picture = Picture.new param
    if @picture.save
      result = []
      pics = @picture.find_by_feature(param[:scenic_id])
      pics.each{|e| result << e[:pic].place }
      result.uniq!
    end
    render :json => result
  end
  
  def show
    @picture = Picture.find params[:id]
    render :json => @picture
  end
  
end
