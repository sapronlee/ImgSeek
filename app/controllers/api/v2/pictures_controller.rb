class Api::V2::PicturesController < Api::V2::ApplicationController
  
  def create
    param = { :scenic_id => params[:scenic], :image => params[:image] }
    @picture = Picture.new param
    if @picture.save
      result = [] 
      pics = @picture.find_by_feature
=begin
      p_arr = @picture.find_by_path
      p_arr.each do |p|
        result << Picture.find(p).place
      end
=end
      pics.each{|o| result << o.place }
      result.uniq!
    end
    render :json => result
  end
  
  def show
    @picture = Picture.find params[:id]
    render :json => @picture
  end
  
end
