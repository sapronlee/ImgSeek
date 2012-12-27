class Api::V3::PicturesController < Api::V3::ApplicationController
  
  def create
    t_create_begin = Time.now
    param = { scenic_id: params[:scenic], image: params[:image] }
    log_info = { ip: request.remote_ip, time: Time.now }
    
    @picture = Picture.new param
    
    t_calc_before = Time.now
    save_ok = @picture.save
    t_calc_after = Time.now
    
    if save_ok
      result = []
      pics, query_time, sort_time, find_time = @picture.find_by_feature(param[:scenic_id])
      msg_records = ""
      pics.each do |e|
        msg_records += "\n  Feature count:" + sprintf("%#3d", e[:fcount]) + " , Matched picture ID: " + e[:pic].id.to_s + " , Matche picture time consuming: " + e[:time_consuming]
        result << e[:pic].place
      end
      result.uniq!
    end
    t_render_before = Time.now
    render :json => result
    t_render_after = Time.now
    t_create_finished = Time.now
    msg_head = "\n  Find unique results : " + result.length.to_s + " , Total time consuming: " + (t_create_finished - t_create_begin).to_s
    msg_head += "(s), Render to JSON time span: " + (t_render_after - t_render_before).to_s + "(s)"
    msg_head += "\n  Calc picture's feature: " + (t_calc_after - t_calc_before).to_s + "(s) , Query db: "+query_time + "(s) , Sort :" + sort_time + "(s) , Statistics :" + find_time + "(s)"
    log_info[:msg] = msg_head + msg_records
    (Log.new log_info).save
  end
  
  def show
    @picture = Picture.find params[:id]
    render :json => @picture
  end
  
end
