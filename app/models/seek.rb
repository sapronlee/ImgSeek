require 'rexml/document'
include REXML

class Seek
  def initialize
  end
  
  def self.request(method_name, db_id = nil, id = nil, path = nil)
    if !method_name.blank? and ["saveAllDbs", "loadAllDbs", "getGlobalServerStats", "getDbDetailedList", "getDbList", "shutdownServer"].include?(method_name)
      body = build_query(:method_name => method_name)
    end
    if !db_id.blank? and ["saveDb", "resetDb", "createDb", "getDbImgCount", "getDbImgIdList", "removeDb", "isValidDb"].include?(method_name)
      body = build_query(:method_name => method_name, :params => { :db_id => db_id })
    end
    if !db_id.blank? and !id.blank? and ["removeImg", "isImgOnDb", "getImgDimensions", "getImgAvgl"].include?(method_name)
      body = build_query(:method_name => method_name, :params => { :db_id => db_id, :id => id })
    end
    if ["queryImgID"].include?(method_name)
      body = build_query(:method_name => method_name, :params => { :db_id => db_id, :id => id, :path => path })
    end
    if ["queryImgPath"].include?(method_name)
      body = build_query(:method_name => method_name, :params => { :db_id => db_id, :path => path })
    end
    result = HTTPI.post("http://localhost:31128/RPC", body, :httpclient)
    Document.new result.raw_body
  end
  
  def self.seed(options = {})
    body = build_query(options)
    result = HTTPI.post("http://localhost:31128/RPC", body, :httpclient)
    Document.new result.raw_body
  end
  
  def self.add_image(picture)
    seed(:method_name => "addImg", 
        :params => { :db_id => picture.scenic_id, :id => picture.id, :filename => picture.image.path })
    seed(:method_name => "saveDb",
        :params => { :db_id => picture.scenic_id })
    save_all_db
  end
  
  def self.reset_db(db_id)
    seed(:method_name => "addImg", :params => { :db_id => db_id })
  end
  
  def self.save_all_db
    seed(:method_name => "saveAllDbs")
  end
  
  def self.create_db(scenic)
    seed(:method_name => "createDb", :params => { :db_id => scenic.id })
    save_all_db
  end
  
  def self.remove_image(picture)
    seed(:method_name => "removeImg", 
        :params => { :db_id => picture.scenic_id, :id => picture.id })
    seed(:method_name => "saveDb",
        :params => { :db_id => picture.scenic_id })
    save_all_db
  end
  
  # options => { :method_name => "queryImgID", :params => { :db_id => 1, :id => 1, :numres => 12, :sketch => 0, :fast => false } }
  def self.build_query(options = {})
    root_xml = Element.new "methodCall"
    if !options[:method_name].blank?
      method_name_xml = Element.new "methodName", root_xml
      method_name_xml.add_text Text.new(options[:method_name])
    end
    
    params_xml = Element.new "params", root_xml
    if !options[:params].blank? and options[:params].kind_of?(Hash)
      options[:params].each_value do |value|
        param_xml = Element.new "param", params_xml
        value_xml = Element.new "value", param_xml
        if value.kind_of?(Integer)
          value_type_xml = Element.new "int", value_xml
        elsif value.kind_of?(TrueClass) or value.kind_of?(FalseClass)
          value_type_xml = Element.new "boolean", value_xml
        else
          value_type_xml = Element.new "string", value_xml
        end
        value_type_xml.add_text Text.new(value.to_s)
      end
    end
    root_xml.to_s
  end
end