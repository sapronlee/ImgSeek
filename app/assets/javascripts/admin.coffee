#= require application
#= require_self

$ ->
  
  $(".albums")
    .find("li").live(
      mouseenter:()->
        $(this).find(".info").find("h3").hide().end().find(".action").show()
      mouseleave:()->
        $(this).find(".info").find("h3").show().end().find(".action").hide()
    )