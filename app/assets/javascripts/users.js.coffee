# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  friend_id = $("#add_friend").data("friend_id")
  user_id = $("#add_friend").data("user_id")
  #alert(user_id)
  #alert(friend_id)
  #$.ajax
    #url: "/relations?friend_id=#{friend_id}"
    #type: "POST"
    #data
      #user_id = $("#add_friend").data("user_id")
      #friend_id = $("#add_friend").data("friend_id")
    #success: ->
      #alert("Success")
    #error: ->
      #alert("Error")
