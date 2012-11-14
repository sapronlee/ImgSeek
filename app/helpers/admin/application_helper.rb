module Admin::ApplicationHelper
  
  def is_storage?(picture)
    if !picture.place_id.zero?
      raw("<i class=\"icon-ok icon-white\"></i>")
    else
      raw("<i class=\"icon-remove icon-white\"></i>")
    end
  end
end
