class Admin::ScenicsController < Admin::ApplicationController
  
  before_filter :add_common_breadcrumb, :except => [:index]
  
	def index
		set_page_tags(t("admin.pages.scenics.index"))
		@scenics = Scenic.page(params[:page]).per(Setting.admin_PageSize)
	end

	def new
		set_page_tags(t("admin.pages.scenics.new"))
		@scenic = Scenic.new
	end

	def create
		set_page_tags(t("admin.pages.scenics.new"))
		@scenic = Scenic.new params[:scenic]
    begin
  		if @scenic.save
  			redirect_to admin_scenics_path, :notice => t("admin.messages.success")
  		else
  			render :new
  		end
    rescue => e
      redirect_to admin_scenics_path, :alert => t(e)
    end
	end

	def edit
		set_page_tags(t("admin.pages.scenics.edit"))
		@scenic = Scenic.find params[:id]
	end

	def update
		set_page_tags(t("admin.pages.scenics.edit"))
		@scenic = Scenic.find params[:id]
    begin
  		if @scenic.update_attributes params[:scenic]
  			redirect_to admin_scenics_path, :notice => t("admin.messages.success")
      else
      	render :edit
      end
    rescue => e
      redirect_to admin_scenics_path, :alert => t(e)
    end
	end

	def destroy
    @scenic = Scenic.find params[:id]
    begin
  		if @scenic.destroy
  			redirect_to admin_scenics_path, :notice => t("admin.messages.success")
  		else
  			redirect_to admin_scenics_path, :alert => t("admin.messages.error")
  		end
    rescue => e
      redirect_to admin_scenics_path, :alert => t(e)
    end
	end

	private
	def add_common_breadcrumb
		add_breadcrumb(t("admin.pages.scenics.index"), admin_scenics_path)
	end
  
end
