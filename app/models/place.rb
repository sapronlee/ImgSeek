class Place < ActiveRecord::Base
  attr_accessible :name, :description, :scenic_id, :audio
  
  # Associations
  belongs_to :scenic, :counter_cache => true
  has_many :pictures, :order => "created_at DESC"
  
  # carrierwave
  mount_uploader :audio, MediaUploader
  
  # Validates
  validates :name, :scenic_id, :audio, :description, :presence => true
	with_options :if => :name? do |name|
    name.validates :name, :length => { :within => 2..20 }
    name.validates :name, :uniqueness => true
  end
  with_options :if => :description? do |description|
  	description.validates :description, :length => { :within => 2..1000 }
  end
  
end
