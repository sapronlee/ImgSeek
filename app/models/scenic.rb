class Scenic < ActiveRecord::Base
  attr_accessible :name
  
  # Associations
  has_many :places, :order => "created_at DESC"
  has_many :pictures, :order => "created_at DESC"
  
  # Callbacks
  after_save :add_db_to_imgseek
  after_destroy :remove_db_to_imgseek
  
  # Validates
  validates :name, :presence => true
	with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..20 }
    name.validates :name, :uniqueness => true
  end
  
  def servers_count
    begin
      Server.get_images(id).size
    rescue
      0
    end
  end
  
  def picture_count
    Picture.where(:scenic_id => id).count
  end
  
  def store
    begin
      Server.refresh_db(id)
      Picture.where("place_id > 0 AND scenic_id = #{id}").find_each(:batch_size => 50) do |picture|
        Server.add_image(id, picture.id, picture.image.path)
      end
      Server.save_db(id)
      true
    rescue
      raise "imgseeks.server.error"
    end
  end
  
  private
  def add_db_to_imgseek
    begin
      Server.add_db(id)
    rescue
      raise "imgseeks.server.error"
    end
  end
  
  def remove_db_to_imgseek
    begin
      Server.remove_db(id)
    rescue
      raise "imgseeks.server.error"
    end
  end
end
