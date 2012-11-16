# encoding: utf-8

class CoverUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper
  
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.pluralize}"
  end
  
  version :thumb do
    process :resize_to_fit => [480, 289]
  end
  
  def default_url
    asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end
  
  def filename
    if super.present?
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{@name}.#{file.extension.downcase}"
    end
  end
  

end
