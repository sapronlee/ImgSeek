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
    no_sig_pictures = Picture.where("sig IS NULL")
    puts no_sig_pictures.length
    no_sig_pictures.each do |e|
      puts e.image.path
      r = KMManager.get_pic_feature(e.image.path)
      puts r[0].length
      puts r[1]
      e.sig = r[0]
      e.siglen = r[1]
      e.save
    end
  end
  
  desc "清除所有手机端上传的所有图片"
  task :clear_unused_pictures => :environment do
    puts "正在搜索未使用的图片...."
    unused_pictures = Picture.where("place_id = 0")
    puts "一共找到未使用的图片" + unused_pictures.length.to_s + "个!"
    unused_pictures.each do |e|
      puts "正在清理: " + e.image.path
      e.destroy
    end
    puts "清理完毕！"
  end
  
  desc "清除所有的日志信息"
  task :clear_log => :environment do
    puts "待清理的日志：" + Log.all.length.to_s + "条！"
    puts "正在执行清理工作 ，请耐心等待..."
    Log.all.each{ |e| e.destroy }
    puts "日志数据清理完毕！"
  end

end