# encoding : utf-8

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
      find_results, query_time, query_records, retrive_query_result_time, sort_time, find_time = @picture.find_by_feature(param[:scenic_id])
      records_log_msg = ""
      find_results.each{|e| result << e[:place]; records_log_msg += e[:log_msg] }
      result.uniq!
    end
    t_create_finished = Time.now
    
    #binding.pry
    log_info[:msg] = format_log({
      result_count: result.length.to_s,
      create_timespan: (t_create_finished - t_create_begin).to_s,
      calc_timespan: (t_calc_after - t_calc_before).to_s,
      query_records: query_records,
      query_time: query_time,
      retrive_timespan: retrive_query_result_time,
      sort_time: sort_time,
      find_time: find_time,
      records_log: records_log_msg
    })
    (Log.new log_info).save
    
    render :json => result
  end
  
  def show
    @picture = Picture.find params[:id]
    render :json => @picture
  end
  
  private
  def format_log(options = { })
    #binding.pry
    msg_head ="\n<br /> 共找到 : <b>" + options[:result_count] + "</b>（条）不重复记录, 共耗时: " + options[:create_timespan] + "(秒)。 计算特征值耗时: " + options[:calc_timespan] + "(秒)" +
            "\n<br />  查询到 : " + options[:query_records] + "（条）记录， 查询耗时: " + options[:query_time] + "(秒) , 遍历查询结果耗时: " + options[:retrive_timespan] + "(秒)" +
            "\n<br />  排序 :" + options[:sort_time] + "(秒)， 统计结果:" + options[:find_time] + "(秒)"
              
    msg_head + options[:records_log]
  end
  
end
