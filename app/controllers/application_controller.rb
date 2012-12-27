class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def set_page_tags(title = nil, keywords = nil, description = nil)
    @page_title = "#{title}" if !title.blank?
    @page_keywords = keywords if !keywords.blank?
    @page_description = description if !description.blank?
    add_breadcrumb(title)
  end
  
  def get_latest_log
    last_log = Log.last
    formated_msg = last_log.nil? ? "" : "Frome IP:" + last_log.ip + " at " + last_log.time.to_s + " time query picture results:" + last_log.msg
  end
end
