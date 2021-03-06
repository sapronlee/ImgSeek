class Picture < ActiveRecord::Base
  attr_accessible :image, :title, :scenic_id, :place_id
  
  # associations
  belongs_to :scenic, :counter_cache => true
  belongs_to :place, :counter_cache => true
  
  # carrierwave
  mount_uploader :image, ImageUploader

  # Callback
  before_save :update_image_attributes, :update_place_attributes
  
  # Validates
  validates :image, :scenic_id, :presence => true

  def find_by_feature(scenic_id)
    begin
     results = []
     t_query_before = Time.now
     stored_pictures = Picture.where("place_id!=0 AND scenic_id=?", scenic_id)
     t_query_after = t_retrieve_before = Time.now
     stored_pictures.each do |i|
       t_calc_before = Time.now
       feature_cnt = KMManager.match_pic_feature(sig, siglen, i.sig, i.siglen)
       t_calc_after = Time.now
       results << { fcount: feature_cnt, pic: i, time_consuming: (t_calc_after - t_calc_before).to_s } # ruby 1.9+ new feature instead of original hashrocket
     end
     t_sort_before = t_retrieve_after = Time.now
     results = results.sort_by{ |e| e[:fcount] }.reverse
     t_sort_after = t_find_before = Time.now
     satisfied_cnt = results.find_all{ |e| e[:fcount] > Setting.threshold }.length
     t_find_after = Time.now
     results = satisfied_cnt.zero? ? results.take(5) : results.take(1), (t_query_after - t_query_before).to_s, stored_pictures.length.to_s, (t_retrieve_after - t_retrieve_before).to_s, (t_sort_after - t_sort_before).to_s, (t_find_after - t_find_before).to_s
    rescue
     raise "imgseeks.server.img_import_error"
    end
  end
  
  private
  def update_image_attributes
    begin
      if image.present? && image_changed?
        self.image_type = MIME::Types.type_for(image.file.original_filename).first.to_s
        self.image_size = image.file.size
        self.title = image.file.basename.strip if title.blank?
        r = KMManager.get_pic_feature(image.path)
        self.sig = r[0]
        self.siglen = r[1]
      end
    rescue
      raise "imgseeks.server.img_import_error"
    end
  end
  
  def update_place_attributes
    self.place_id = 0 if self.place_id.blank?
  end
end
