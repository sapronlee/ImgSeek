class Admin::PicturesController < Admin::ApplicationController
  
  before_filter :get_place_and_add_breadcrumb
  before_filter :add_common_breadcrumb, :except => [:index]
  
	def index
		set_page_tags(t("admin.pages.pictures.index"))
    if @place.blank?
      @pictures = Picture.where(:place_id => 0).order("created_at DESC").page(params[:page]).per(Setting.admin_PhotoPageSize)
    else
      @pictures = @place.pictures.order("created_at DESC").page(params[:page]).per(Setting.admin_PhotoPageSize)
    end
	end
  
  def show
    @picture = Picture.find params[:id]
    set_page_tags(@picture.title)
  end

	def new
		set_page_tags(t("admin.pages.pictures.new"))
		@picture = Picture.new
	end

	def create
		set_page_tags(t("admin.pages.pictures.new"))
		@picture = Picture.new params[:picture]
    begin
  		if @picture.save
  			redirect_to admin_pictures_path, :notice => t("admin.messages.success")
  		else
  			render :new
  		end
    rescue => e
      redirect_to (@place.blank? ? admin_pictures_path : admin_place_pictures_path(@place)), :alert => t(e)
    end
	end

	def edit
		set_page_tags(t("admin.pages.pictures.edit"))
		@picture = Picture.find params[:id]
	end

	def update
		set_page_tags(t("admin.pages.pictures.edit"))
		@picture = Picture.find params[:id]
    begin
  		if @picture.update_attributes params[:picture]
  			redirect_to admin_pictures_path, :notice => t("admin.messages.success")
      else
      	render :edit
      end
    rescue => e
      redirect_to (@place.blank? ? admin_pictures_path : admin_place_pictures_path(@place)), :alert => t(e)
    end
	end

	def destroy
    @picture = Picture.find params[:id]
    begin
  		if @picture.destroy
  			redirect_to (@place.blank? ? admin_pictures_path : admin_place_pictures_path(@place)), :notice => t("admin.messages.success")
  		else
  			redirect_to (@place.blank? ? admin_pictures_path : admin_place_pictures_path(@place)), :alert => t("admin.messages.error")
  		end
    rescue => e
      redirect_to (@place.blank? ? admin_pictures_path : admin_place_pictures_path(@place)), :alert => t(e)
    end
	end

	private
	def add_common_breadcrumb
    add_breadcrumb(t("admin.pages.pictures.index"), admin_pictures_path) if @place.blank?
	end
  
  def get_place_and_add_breadcrumb
    if !params[:place_id].blank?
      @place = Place.find(params[:place_id])
      add_breadcrumb(t("admin.pages.places.index"), admin_places_path)
      add_breadcrumb(@place.name, admin_place_pictures_path(@place))
    end
  end
  
end
