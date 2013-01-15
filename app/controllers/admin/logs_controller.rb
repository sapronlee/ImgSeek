class Admin::LogsController < Admin::ApplicationController
  def index
    set_page_tags(t("admin.pages.logs.index"))
    @logs = Log.page(params[:page]).order("created_at DESC").per(Setting.admin_PageSize)
  end

  def destroy
    @log = Log.find params[:id]
    begin
      if @log.destroy
        redirect_to admin_logs_path, :notice => t("admin.messages.success")
      else
        redirect_to admin_logs_path, :alert => t("admin.messages.error")
      end
    rescue => e
      redirect_to admin_logs_path, :alert => t(e)
    end
  end

end