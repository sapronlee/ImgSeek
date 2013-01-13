class Scenic < ActiveRecord::Base
  attr_accessible :name

  # Associations
  has_many :places, :order => "created_at DESC", :dependent => :destroy
  has_many :pictures, :order => "created_at DESC"

  # Validates
  validates :name, :presence => true
  with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..20 }
    name.validates :name, :uniqueness => true
  end

  def servers_count
    begin
      Picture.where("scenic_id=? AND place_id != 0", id).count
    rescue
    0
    end
  end

  def pictures_count
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
