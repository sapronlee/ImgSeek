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
end
