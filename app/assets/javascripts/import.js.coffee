ready = ->
  $real_field = $('#import_file')

  $real_field.change ->
#    $('#file_name').val $(@).val().replace(/^.*[\\\/]/, '')

  $('#upload_lnk').click ->
    $real_field.click()


$(document).ready(ready)