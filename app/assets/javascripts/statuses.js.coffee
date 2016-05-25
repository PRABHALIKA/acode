# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#status-update').click (event)->
    event.preventDefault()
    $('.new_status').slideToggle 300
  a = $('#status_status').val().replace(/ /g,'').length
  $('#status_status').keyup ->
    status_text = $(this).val()
    if (status_text.length < 5)
      $('input[type="submit"]').attr('disabled', 'disabled')
    else
      $('input[type="submit"]').removeAttr('disabled')
  status_text = $(this).val()
  if status_text.length = 0
    $('#status_clear').attr('disabled', 'disabled')
  $('#status_clear').click (event)->
    event.preventDefault()
    if confirm('Are you sure to clear the status?') == true
      $('#status_status').val ''
      $('input[type="submit"]').attr('disabled', 'disabled')
  $('#status_close').click ->
    $('.new_status').slideUp 350
  $('#notice_wrapper').fadeOut 4500
  #$("#status_post").click ->
  #  $(this).attr('disabled', 'disabled')
