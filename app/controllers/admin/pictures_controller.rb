class Admin::PicturesController < Admin::ApplicationController
  
  before_filter :add_common_breadcrumb, :except => [:index]
  
	def index
		set_page_tags(t("admin.pages.pictures.index"))
    @pictures = Picture.order("created_at DESC").page(params[:page]).per(Setting.admin_PhotoPageSize)
	end
  
  def store
    Seek.reset_db(1)
    Picture.find_each do |picture|
      Seek.add_image(picture) if !picture.place_id.zero?
    end
    Seek.save_all_db
    redirect_to admin_pictures_path, :notice => t("admin.messages.success")
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
		if @picture.save
      Seek.add_image(@picture) if !@picture.place_id.zero? 
			redirect_to admin_pictures_path, :notice => t("admin.messages.success")
		else
			render :new
		end
	end

	def edit
		set_page_tags(t("admin.pages.pictures.edit"))
		@picture = Picture.find params[:id]
	end

	def update
		set_page_tags(t("admin.pages.pictures.edit"))
		@picture = Picture.find params[:id]
		if @picture.update_attributes params[:picture]
      Seek.add_image(@picture) if !@picture.place_id.zero? 
			redirect_to admin_pictures_path, :notice => t("admin.messages.success")
    else
    	render :edit
    end
	end

	def destroy
    @picture = Picture.find params[:id]
		if @picture.destroy
      Seek.remove_image(@picture)
			redirect_to admin_pictures_path, :notice => t("admin.messages.success")
		else
			redirect_to admin_pictures_path, :alert => t("admin.messages.error")
		end
	end

	private
	def add_common_breadcrumb
		add_breadcrumb(t("admin.pages.pictures.index"), admin_pictures_path)
	end
  
end
