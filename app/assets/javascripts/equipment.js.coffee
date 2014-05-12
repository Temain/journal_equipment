# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('#Container').mixItUp();

  $(".nav-item > button").click ->
    $(".nav-item").removeClass("active")
    $(this).parent().addClass("active")

  # manufacturers typeahead
  manufacturers =
    new Bloodhound
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      prefetch: '/load_manufacturers',
      remote: '/load_manufacturers/?query=%QUERY'

  manufacturers.initialize();

  $('#remote .typeahead.manufacturer').typeahead(null, {
    name: 'manufacturers',
    displayKey: 'name',
    source: manufacturers.ttAdapter()
  });

  # equipment typeahead
  equipment =
    new Bloodhound
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      prefetch: '/load_equipment',
      remote: '/load_equipment/?query=%QUERY'

  equipment.initialize();

  $('#remote .typeahead.search-equipment').typeahead(null, {
    name: 'equipment',
    displayKey: (equipment) ->
        return "#{equipment.equipment_type.name} #{equipment.manufacturer.name} #{equipment.model}";
    source: equipment.ttAdapter()
    templates: {
      empty: [
        '<div class="empty-message">',
        'Ничего не найдено =(',
        '</div>'
      ].join('\n'),
      suggestion: (data) ->
        return '<p><strong>' + data.equipment_type.name + ' ' + data.manufacturer.name + '</strong> ' + data.model + '</p>';
    }
  }).on('typeahead:selected', (obj, equipment) ->
    $('#equipment_model').val(equipment.model);
    $('#manufacturer_name').val(equipment.manufacturer.name);
    $('#equipment_equipment_type_id').val(equipment.equipment_type.id);
  )



  # prevent form submit on enter
  $(window).keydown ->
    if(event.keyCode == 13)
      event.preventDefault();
      return false;


$(document).ready(ready)
$(document).on('page:load', ready)
