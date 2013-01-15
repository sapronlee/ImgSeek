# encoding: utf-8
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
    formated_msg = last_log.nil? ? "" : "来自IP为:" + last_log.ip + "的用户, 在" + last_log.time.to_s + "向服器发了请求。" + last_log.msg
  end
end
