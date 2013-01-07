require File.expand_path('mytest.so', Rails.root) # be sure rails search lib path order.

class KMManager
  @@matcher = MyTest.new
  
  def self.get_pic_feature(file_path, options = { })
    options[:flag] ||= 2|4|8
    options[:width] ||= 800
    options[:height] ||= 600
    options[:blur_type] ||= 0x02
    options[:feature_count] = 500
    
    #@@matcher.GetImgFeature(file_path, options[:flag], options[:width], options[:height], options[:blur_type], options[:feature_count])
    @@matcher.GetImgFeature(file_path, options[:flag], options[:width], options[:blur_type], options[:feature_count])
  end
  
  def self.match_pic_feature(src_pic_buffer, src_buffer_len, cmp_pic_buffer, cmp_buffer_len)
    begin
      @@matcher.MatchImgFeature(src_pic_buffer, src_buffer_len, cmp_pic_buffer, cmp_buffer_len)
    end
  end
end