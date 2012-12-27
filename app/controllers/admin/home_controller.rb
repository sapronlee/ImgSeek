class Admin::HomeController < Admin::ApplicationController
  
  def index
    set_page_tags(t("admin.pages.home.index"))
    @server_logs = get_latest_log
  end
  
end
