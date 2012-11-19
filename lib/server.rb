require "xmlrpc/client"

class Server
  @@server = XMLRPC::Client.new2("http://localhost:31128/RPC")
  
  def self.get_server_status
    begin
      result = @@server.call("getGlobalServerStats")
    rescue Errno::ECONNREFUSED
      result = { "status" => "error" }
    rescue EOFError
      result = { "status" => "error" }
    end
    result
  end
  
  def self.find_image(db_id, path, num = 12, sketch = 0, fast = false)
    begin
      @@server.call("queryImgPath", db_id, path, num, sketch, fast)
    rescue
      nil
    end
  end
  
  def self.add_image(db_id, id, filename)
    begin
      if !image_exist?(db_id, id)
        @@server.call("addImg", db_id, id, filename)
        save_db(db_id)
      end
    end
  end
  
  def self.remove_image(db_id, id)
    begin
      if image_exist?(db_id, id)
        @@server.call("removeImg", db_id, id)
        save_db(db_id)
      end
    end
  end
  
  def self.image_exist?(db_id, id)
    begin
      @@server.call("isImgOnDb", db_id, id)
    end
  end
  
  def self.get_images(db_id)
    begin
      @@server.call("getDbImgIdList", db_id)
    end
  end
  
  def self.db_exist?(db_id)
    begin
      @@server.call("isValidDb", db_id)
    end
  end
  
  def self.add_db(db_id)
    begin
      @@server.call("createDb", db_id) if !db_exist?(db_id)
    end
  end
  
  def self.remove_db(db_id)
    begin
      @@server.call("removeDb", db_id) if db_exist?(db_id)
    end
  end
  
  def self.save_db(db_id)
    begin
      @@server.call("saveDb", db_id)
    end
  end
  
  def self.log(window = 10)
    begin
      result = @@server.call("getIskLog", window)
    rescue
      result = "error"
    end
  end
  
  def self.reset_db(db_id)
    begin
      @@server.call("resetDb", db_id)
    end
  end
  
  def self.refresh_db(db_id)
    begin
      if db_exist?(db_id)
        reset_db(db_id)
      else
        add_db(db_id)
      end
    end
  end
end