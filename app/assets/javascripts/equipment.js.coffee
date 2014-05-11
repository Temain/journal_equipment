# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('#Container').mixItUp();

  $(".nav-item > button").click ->
    $(".nav-item").removeClass("active")
    $(this).parent().addClass("active")

  # manufacturers typeahead
  bestPictures =
    new Bloodhound
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      prefetch: '/load_manufacturers',
      remote: '/load_manufacturers/?query=%QUERY'

  bestPictures.initialize();

  $('#remote .typeahead.manufacturer').typeahead(null, {
    name: 'manufacturers',
    displayKey: 'name',
    source: bestPictures.ttAdapter()
  });

  # equipments typeahead
  bestPictures =
    new Bloodhound
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      prefetch: '/load_equipment',
      remote: '/load_equipment/?query=%QUERY'

  bestPictures.initialize();

  $('#remote .typeahead.search-equipment').typeahead(null, {
    name: 'full_name',
    displayKey: 'model',
    source: bestPictures.ttAdapter()
  });

  # prevent form submit on enter
  $(window).keydown ->
    if(event.keyCode == 13)
      event.preventDefault();
      return false;


$(document).ready(ready)
$(document).on('page:load', ready)
