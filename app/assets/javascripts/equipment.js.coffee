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

  # get relocation modal invoker
  $('#relocation_modal').on('show.bs.modal',(e) ->
    invoker = $(e.relatedTarget);
    item_id = invoker[0].attributes.id.value;
    $('#relocation_modal form').attr('action', '/equipment/'+ item_id + '/relocation');
    $('#new_department_id_').val(null)
  )

  # get repair modal invoker
  equipment_type_id = $('#repair_modal').on('show.bs.modal',(e) ->
    invoker = $(e.relatedTarget);
    item_id = invoker[0].attributes.id.value;
    equipment_type_id = invoker[0].attributes.equipment_type_id.value;
    $('#repair_modal form').attr('action', '/equipment/'+ item_id + '/repair');
    equipment_type_id
  )

  format = (spare) ->
 #    if (!spare.id)
      spare.name + " --- "

  load_spares_path = ->
    '/load_spares/' + String(equipment_type_id);

  # select2 intialize
  $("#spares").select2({
    placeholder: "Выберите детали...",
    multiple: true,
    ajax: {
      url: load_spares_path,
      dataType: 'json',
      data: (term, page) ->
        { q: term };
      ,
      results: (data, page) ->
        { results: data };
    }

    formatResult: format,
    formatSelection: format
  });


  # prevent form submit on enter
  $('#remote .typeahead').keydown ->
    if(event.keyCode == 13)
      event.preventDefault();
      return false;



$(document).ready(ready)
$(document).on('page:load', ready)
