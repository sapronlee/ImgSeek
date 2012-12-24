class Scenic < ActiveRecord::Base
  attr_accessible :name

  # Associations
  has_many :places, :order => "created_at DESC"
  has_many :pictures, :order => "created_at DESC"

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
      Picture.where("place_id > 0 AND scenic_id = #{id}").find_each(:batch_size => 50) do |picture|
      end
      true
    rescue
      raise "imgseeks.server.error"
    end
  end
end
