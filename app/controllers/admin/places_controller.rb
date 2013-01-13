class Admin::PlacesController < Admin::ApplicationController
  
  before_filter :get_scenic
  before_filter :add_common_breadcrumb, :except => [:index]
  
	def index
		set_page_tags(t("admin.pages.places.index"))
    if !@scenic.blank?
      @places = @scenic.places.page(params[:page]).per(Setting.admin_PageSize)
    else
      @places = Place.page(params[:page]).per(Setting.admin_PageSize)
    end
	end

	def new
		set_page_tags(t("admin.pages.places.new"))
		@place = Place.new
	end

	def create
		set_page_tags(t("admin.pages.places.new"))
		@place = Place.new params[:place]
		if @place.save
			redirect_to admin_place_pictures_path(@place), :notice => t("admin.messages.success")
		else
			render :new
		end
	end

	def edit
		set_page_tags(t("admin.pages.places.edit"))
		@place = Place.find params[:id]
	end

	def update
		set_page_tags(t("admin.pages.places.edit"))
		@place = Place.find params[:id]
		if @place.update_attributes params[:place]
			redirect_to admin_places_path, :notice => t("admin.messages.success")
    else
    	render :edit
    end
	end

	def destroy
    @place = Place.find params[:id]
		if @place.destroy
			redirect_to admin_places_path, :notice => t("admin.messages.success")
		else
			redirect_to admin_places_path, :alert => t("admin.messages.error")
		end
	end

	private
  def get_scenic
    @scenic = Scenic.find params[:scenic_id] if !params[:scenic_id].blank?
  end
	def add_common_breadcrumb
		add_breadcrumb(t("admin.pages.places.index"), admin_places_path)
	end
end
