class Admin::HomeController < Admin::ApplicationController
  
  def index
    set_page_tags(t("admin.pages.home.index"))
    @isk_daemon = Server.get_server_status
    @isk_daemon_log = Server.log
  end
  
end
