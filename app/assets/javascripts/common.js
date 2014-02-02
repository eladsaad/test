$(function() {

  $('.datepicker').datepicker({
    dateFormat: "yy-mm-dd"
  });

  $('.autocomplete-field').each(function(){

    // data source url
    var autocomplete_source = $(this).data('autocomplete-source');
    // name of the result object's attribute to use as label
    var autocomplete_label_att = $(this).data('autocomplete-label-att');
    // name of the result object's attribute to use as value
    var autocomplete_value_att = $(this).data('autocomplete-value-att');
    // id of the input field that should hold the selected value
    var autocomplete_value_input_id = $(this).data('autocomplete-value-input-id');


    $(this).autocomplete({
      minLength: 2,
      source: function( request, response ) {
        $.ajax({
          url: autocomplete_source,
          dataType: "json",
          data: {
            search: request.term
          },
          success: function( data ) {
            // map resulting item according to the chosen label/value attributes
            response( $.map( data, function( item ) {
              return {
                label: item[autocomplete_label_att],
                hidden_value: item[autocomplete_value_att]
              }
            }));
          }
        });
      },
      select: function( event, ui ) {
        // update value on the chosen input field
        if (autocomplete_value_input_id) {
          $('#'+autocomplete_value_input_id).val( ui.item.hidden_value );
        }
      },
      change: function( event, ui ) {
        if(!ui.item){
          $(this).val("");
        }
      }
    });
  });
});
