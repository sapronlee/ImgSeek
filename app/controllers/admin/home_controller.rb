class Admin::HomeController < Admin::ApplicationController
  
  def index
    set_page_tags(t("admin.pages.home.index"))
    @server_status = Server.get_server_status
    @server_logs = Server.log
  end
  
end
