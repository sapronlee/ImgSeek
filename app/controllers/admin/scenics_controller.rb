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
		if @scenic.save
      Seek.create_db(@scenic)
			redirect_to admin_scenics_path, :notice => t("admin.messages.success")
		else
			render :new
		end
	end

	def edit
		set_page_tags(t("admin.pages.scenics.edit"))
		@scenic = Scenic.find params[:id]
	end

	def update
		set_page_tags(t("admin.pages.scenics.edit"))
		@scenic = Scenic.find params[:id]
		if @scenic.update_attributes params[:scenic]
			redirect_to admin_scenics_path, :notice => t("admin.messages.success")
    else
    	render :edit
    end
	end

	def destroy
    @scenic = Scenic.find params[:id]
		if @scenic.destroy
			redirect_to admin_scenics_path, :notice => t("admin.messages.success")
		else
			redirect_to admin_scenics_path, :alert => t("admin.messages.error")
		end
	end

	private
	def add_common_breadcrumb
		add_breadcrumb(t("admin.pages.scenics.index"), admin_scenics_path)
	end
  
  
end
