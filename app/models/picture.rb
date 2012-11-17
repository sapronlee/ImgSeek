class Picture < ActiveRecord::Base
  attr_accessible :image, :title, :scenic_id, :place_id
  
  # associations
  belongs_to :scenic, :counter_cache => true
  belongs_to :place, :counter_cache => true
  
  # carrierwave
  mount_uploader :image, ImageUploader
  
  # filter
  before_save :update_image_attributes, :update_place_attributes
  
  # Validates
  validates :image, :scenic_id, :presence => true
  
  # scope :latest, order_by(:created_at => :desc)
  
  def search_pictures
    doc = Seek.seed(:method_name => "queryImgPath", :params => { :db_id => self.scenic_id, :path => self.image.path, :numres => 1 })
    els = []
    doc.elements.to_a("//data//array").each do |e|
      similarity = XPath.first(e, "*//double").text.to_f
      pictrue_id = XPath.first(e, "*//int").text.to_i
      puts "result id:#{pictrue_id}, similarity:#{similarity}"
      if similarity > Setting.similarity
        els << [pictrue_id, similarity]
        break
      end
    end
    return els
  end
  
  private
  def update_image_attributes
    if image.present? && image_changed?
      self.image_type = image.file.content_type
      self.image_size = image.file.size
      self.title = image.file.basename.strip if title.blank?
    end
  end
  
  def update_place_attributes
    self.place_id = 0 if self.place_id.blank?
  end

end
