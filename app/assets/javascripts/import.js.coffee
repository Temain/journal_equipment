ready = ->
  $real_field = $('#import_file')

  $real_field.change ->
    file_name = $(@).val().replace(/^.*[\\\/]/, '')
    temp = file_name.split(".")
    file_name = temp[0]
    file_ext = "." + temp[1]
    if file_name.length > 16
      file_name = temp[0].substr(0,12)

    $('#upload_lnk > div > .file-name').text file_name
    $('#upload_lnk > div > .file-ext').text file_ext

  $('#upload_lnk').click ->
    $real_field.click()

  $('#import_lnk').click ->
    if $real_field.val()
      NProgress.start()
      $('#import_form').submit()

$(document).ready(ready)