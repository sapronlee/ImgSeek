#= require application
#= require jquery/timers
#= require_self

$ ->
  
  $.ajaxSetup
    cache: true
  
  $(".albums")
    .find("li").live(
      mouseenter:()->
        $(this).find(".info").find("h3").hide().end().find(".action").show()
      mouseleave:()->
        $(this).find(".info").find("h3").show().end().find(".action").hide()
    )
  
  $("div#server").everyTime('5s', 
    ()-> 
      $.getScript("/admin")
  )
  
  return