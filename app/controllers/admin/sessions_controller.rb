class Admin::SessionsController < Devise::SessionsController
  layout "admin/application"
  
  def after_sign_out_path_for(resource_or_scope)
    admin_root_path
  end

end