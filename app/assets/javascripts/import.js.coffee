ready = ->
  $real_field = $('#import_file')

  $real_field.change ->
    $('#upload_lnk').val $(@).val().replace(/^.*[\\\/]/, '')

  $('#upload_lnk').click ->
    $real_field.click()

  $('#import_lnk').click ->
    $('#import_form').submit()

$(document).ready(ready)