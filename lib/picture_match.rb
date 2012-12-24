require File.expand_path('mytest.so', Rails.root)
#require File.expand_path('./lib/mytest.so', Rails.root) # should be move the libpicmatch.so in project root directory. rails default path is Rails.root

class PictureMatch
  @@matcher = MyTest.new
  
  def self.get_pic_feature(file_path, flag = 2|4|8, width = 800, height=600, blur_type = 0x02, feature_count = 500)
    begin
      @@matcher.GetImgFeature(file_path, flag, width, height, blur_type, feature_count)
    end
  end
  
  def self.match_pic_feature(src_pic_buffer, src_buffer_len, cmp_pic_buffer, cmp_buffer_len)
    begin
      @@matcher.MatchImgFeature(src_pic_buffer, src_buffer_len, cmp_pic_buffer, cmp_buffer_len)
    end
  end
end