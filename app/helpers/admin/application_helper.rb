module Admin::ApplicationHelper
  
  def is_storage?(picture)
    if !picture.place_id.zero?
      raw("<i class=\"icon-ok icon-white\"></i>")
    else
      raw("<i class=\"icon-remove icon-white\"></i>")
    end
  end
  
  def translate_format(source, t_prefix = nil)
    if !t_prefix.nil?
      t("#{t_prefix}.#{source.gsub(/[\s-]/, "_").downcase}")
    else
      t("#{source.gsub(/[\s-]/, "_").downcase}")
    end
  end
  
  def is_active(action_name, type)
    button_status = action_name == type ? "btn active" : "btn"
  end
  
end
