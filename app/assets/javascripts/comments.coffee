# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#comment-update').click (event)->
    event.preventDefault()
    $('.new_comment').slideToggle 300
  $('#comment_content').keyup ->
    status_text = $(this).val()
    if (status_text.length < 5)
      $('input[type="submit"]').attr('disabled', 'disabled')
    else
      $('input[type="submit"]').removeAttr('disabled')