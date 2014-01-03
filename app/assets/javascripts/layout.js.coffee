$ ->
  $('img').error ->
    $(this).prop('src', "/assets/placeholder.png")
  $.each ($ ".crush"), (index, element)    -> new Crush $(element)
  $.each ($ ".bookmark"), (index, element) -> new Bookmark $(element)
  

class UserAction
  constructor: (@element) ->
    @username = @element.data("username")
    @element.click (event) => 
      this.crush() 
      false
      
  token: ->
    $('meta[name=csrf-token]:first').attr("content")
    
  crush: =>
    $.ajax @element.attr('href') + ".json",
      type: @element.data('method'),
      data: {authenticity_token: this.token(), format: "json"},
      success: (data) => this.crushButton(@element.data('method'))
      
  crushButton: (method) =>
    elements = ($ ".#{this.className()}[data-username='#{@username}']")
    if method == "delete"
      elements.attr('href', this.createHref())
      elements.html(this.createHtml())
      elements.data('method', "post")
    else
      elements.attr('href', this.deleteHref())
      elements.html(this.deleteHtml())
      elements.data('method', "delete")
      
      
class Crush extends UserAction
  className:  => "crush"
  createHref: => "/@#{@username}/crush"
  createHtml: => "<i class=\"fa fa-heart\"></i> <b>Crush</b>"
  deleteHref: => "/@#{@username}/uncrush"
  deleteHtml: => "<i class=\"fa fa-ban\"></i> <b>Uncrush</b>"
    
class Bookmark extends UserAction
  className:  => "bookmark"
  createHref: => "/@#{@username}/bookmark"
  createHtml: => "<i class=\"fa fa-star\"></i>"
  deleteHref: => "/@#{@username}/unbookmark"
  deleteHtml: => "<i class=\"fa fa-ban\"></i>"
