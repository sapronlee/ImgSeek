class Admin::ApplicationController < ApplicationController
  
	layout "admin"

  # before_filter :authenticate_user!
	before_filter :cpanel_breadcrumb

	def cpanel_breadcrumb
		#add_breadcrumb(t("admin.root"), admin_root_path)
	end
  
end
