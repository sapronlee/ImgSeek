class Admin::ApiController < Admin::ApplicationController
  
  before_filter :add_common_breadcrumb
  
  def v1
    set_page_tags(t("admin.pages.api.v1"))
  end
  
  def v2
    set_page_tags(t("admin.pages.api.v2"))
  end
  
  def v3
    set_page_tags(t("admin.pages.api.v3"))
  end
  
	private
	def add_common_breadcrumb
    add_breadcrumb(t("admin.menus.api"), v3_admin_api_index_path)
	end
  
end
