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
      #prefetch: '/load_manufacturers',
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
      #prefetch: '/load_equipment',
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
    $('#new_department_id_').val(null);
  )

  # get repair modal invoker
  equipment_type_id = $('#repair_modal').on('show.bs.modal',(e) ->
    $("#spares").select2('data', null); # clear selection
    $("reason_").val("");
    invoker = $(e.relatedTarget);
    item_id = invoker[0].attributes.id.value;
    equipment_type_id = invoker[0].attributes.equipment_type_id.value;
    $('#repair_modal form').attr('action', '/equipment/'+ item_id + '/repair');
    equipment_type_id
  )

  # --------- select2 intialize ----------
  format = (spare) ->
      spare.name;

  load_spares_path = ->
    '/load_spares/' + String(equipment_type_id);

  lastResults = [];
  $("#spares").select2({
    placeholder: "Выберите детали...",
    multiple: true,
    ajax: {
      url: load_spares_path,
      dataType: 'json',
      data: (term, page) ->
        q: term;
      ,
      results: (data, page) ->
        lastResults = data;
        results: data;
    }

    formatResult: format,
    formatSelection: format,

    createSearchChoice: (term) ->
      if(lastResults.some((r) -> r.name == term ))
         id: term, name: term;
      else
         id: term, name: term + " (новая деталь)";
  });

  # item action menu
  $("a.actions-link").on('click', (e) ->
    #$(".actions > a").css("visibility", "visible");
    actions = $( this ).parent();
    actions.addClass("showed");
    actions_links = $(".actions.showed a").not("a.actions-link");
    $(".showed > a.actions-link").hide("fast");
    $.each(actions_links, (index, obj) ->
       $(this).show("fast");
    )
  )

  # prevent form submit on enter
  $('#remote .typeahead').keydown ->
    if(event.keyCode == 13)
      event.preventDefault();
      return false;



$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('click', (e) ->
  if( (!$(e.target).is('.actions.showed > a > i')))
    $(".actions.showed > a").not("a.actions-link").hide(1000);
    $(".showed > a.actions-link").show("fast");
    $(".actions.showed").removeClass("showed");
)
$(document).on('page:fetch', ->
  $('#Container').mixItUp('destroy');
)

$(document).on('page:load', ->
  $('#Container').mixItUp();
)