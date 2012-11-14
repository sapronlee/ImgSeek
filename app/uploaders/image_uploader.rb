# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  
  include CarrierWave::MiniMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper
  
  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.pluralize}"
  end
  
  version :thumb do
    process :resize_to_thumb => [205, 140]
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
  
  private
  
  def resize_to_thumb(width, height)
    manipulate! do |img|
      cols, rows = img[:dimensions]
      if cols < width and rows < height
        img.resize "#{width}x#{height}>"
        puts "ok"
      else
        puts "error"
        img.combine_options do |cmd|
          if width != cols || height != rows
            scale_x = width/cols.to_f
            scale_y = height/rows.to_f
            if scale_x >= scale_y
              cols = (scale_x * (cols + 0.5)).round
              rows = (scale_x * (rows + 0.5)).round
              cmd.resize "#{cols}"
            else
              cols = (scale_y * (cols + 0.5)).round
              rows = (scale_y * (rows + 0.5)).round
              cmd.resize "x#{rows}"
            end
          end
          cmd.gravity 'Center'
          cmd.background "rgba(255,255,255,0.0)"
          cmd.extent "#{width}x#{height}" if cols != width || rows != height
        end
      end
      img = yield(img) if block_given?
      img
    end
  end

end
