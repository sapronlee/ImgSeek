# encoding : utf-8
namespace :imgseek do
  desc "全部景区入库"
  task :store => :environment do
    Scenic.find_each(:batch_size => 50) do |scenic|
      puts "======================================"
      puts "景点：#{scenic.name}"
      puts "======================================"
      begin
        Server.refresh_db(scenic.id)
        scenic.pictures.where("place_id > 0").find_each(:batch_size => 50) do |picture|
          Server.add_image(scenic.id, picture.id, picture.image.path)
          puts "== #{picture.id}"
        end
        Server.save_db(scenic.id)
      rescue
        puts "`ImgSeek` 服务器错误！"
      end
    end
  end

  desc "清除无效的景区"
  task :clean => :environment do
    begin
      result = Server.get_dbs
      result.each do |item|
        scenic = Scenic.find_by_id(item)
        Server.remove_db(item) if scenic.blank?
      end
    rescue
      puts "`ImgSeek` 服务器错误！"
    end
  end

  desc "Caculate the sig of each picture stored in the database"
  task :calc_sig => :environment do
    no_sig_pictures = Picture.where("sig IS NULL AND place_id != 0")
    puts no_sig_pictures.length
    no_sig_pictures.each do |e|
      puts e.image.path
      r = PictureMatch.get_pic_feature(e.image.path)
      puts r[0].length
      puts r[1]
      e.sig = r[0]
      e.siglen = r[1]
      e.save
    end
  end

end