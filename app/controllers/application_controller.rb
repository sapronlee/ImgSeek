class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def set_page_tags(title = nil, keywords = nil, description = nil)
    @page_title = "#{title}" if !title.blank?
    @page_keywords = keywords if !keywords.blank?
    @page_description = description if !description.blank?
    add_breadcrumb(title)
  end
end
