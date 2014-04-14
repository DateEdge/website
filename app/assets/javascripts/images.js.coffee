rotateImage = (obj, degrees) =>
  obj.css("transform", "rotate(#{degrees}deg)")
  obj.css("-webkit-transform", "rotate(#{degrees}deg)")
  obj.css("-moz-transform", "rotate(#{degrees}deg)")
  obj.css("-ms-transform", "rotate(#{degrees}deg)")
  
$ ->
  $(".image-manipulator").click ->
    obj = $("#photo_manipulate")
    input = $('<input>').attr {type: 'hidden'}
    input.attr("name", "photo[manipulate][rotate]")
    switch $(this).attr("href")
      when "#rotate-left"
        obj.data("rotate", obj.data("rotate") - 90)
      when "#rotate-right"
        obj.data("rotate", obj.data("rotate") + 90)

    rotateImage($("#preview img"), obj.data('rotate'))
    
    input.val obj.data("rotate")
    $("#photo_manipulate").html(input)
    