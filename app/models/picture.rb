class Picture < ActiveRecord::Base
  attr_accessible :image, :title, :scenic_id, :place_id
  
  # associations
  belongs_to :scenic, :counter_cache => true
  belongs_to :place, :counter_cache => true
  
  # carrierwave
  mount_uploader :image, ImageUploader
  
  # filter
  before_save :update_image_attributes, :update_place_attributes
  after_save :add_image_to_imgseek
  after_destroy :remove_image_to_imgseek
  
  # Validates
  validates :image, :scenic_id, :presence => true
  
  # result is pictrue.id array
  def find_by_path
    result = []
    server_result = Server.find_image(scenic_id, image.path)
    server_result.each do |i|
      result << i.first if i.last > Setting.similarity
    end
    result
  end
  
  private
  def update_image_attributes
    if image.present? && image_changed?
      self.image_type = MIME::Types.type_for(image.file.original_filename).first.to_s
      self.image_size = image.file.size
      self.title = image.file.basename.strip if title.blank?
    end
  end
  
  def update_place_attributes
    self.place_id = 0 if self.place_id.blank?
  end
  
  def remove_image_to_imgseek
    begin
      if !place_id.zero?
        Server.remove_image(scenic_id, id)
        Server.save_db(scenic_id)
      end
    rescue
      raise "imgseeks.server.error"
    end
  end
  
  def add_image_to_imgseek
    begin
      if !place_id.zero?
        Server.add_image(scenic_id, id, image.path)
        Server.save_db(scenic_id)
      end
    rescue
      raise "imgseeks.server.error"
    end
  end

end
