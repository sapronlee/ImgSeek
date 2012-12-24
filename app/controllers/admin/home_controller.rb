class Admin::HomeController < Admin::ApplicationController
  
  def index
    set_page_tags(t("admin.pages.home.index"))
=begin
    @server_status = Server.get_server_status
    @server_logs = Server.log
=end
    @server_logs = request.remote_ip
  end
  
end
