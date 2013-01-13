class Place < ActiveRecord::Base
  attr_accessible :name, :description, :scenic_id, :audio, :cover
  
  # Associations
  belongs_to :scenic, :counter_cache => true
  has_many :pictures, :order => "created_at DESC", :dependent => :destroy
  
  # carrierwave
  mount_uploader :audio, MediaUploader
  mount_uploader :cover, CoverUploader
  
  # Validates
  validates :name, :scenic_id, :audio, :description, :cover, :presence => true
	with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..20 }
    name.validates :name, :uniqueness => true
  end
  with_options :if => :description? do |description|
  	description.validates :description, :length => { :within => 2..10000 }
  end
  
  def pictures_count
    Picture.where(:place_id => id).count
  end
  
  # Scopes
  scope :search_by_name, lambda { |name| where("ucase(`places`.`name`) like concat('%',ucase(?),'%')", name) }
  
end
