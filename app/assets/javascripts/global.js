$(document).ready(function(){
  // Disable Submit on Enter

  //$(".disable-submit").bind("keypress", function(e) {
  //  if (e.keyCode == 13) return false;
  //});

  // Initialize collapse button
  $(".button-collapse").sideNav();

  // Make flash disapear
  //
  setTimeout(function(){
    $(".flash").fadeOut();
  }, 3000);

  // Activate Select
  $('select').material_select();

  // Activate Datepicker
  $('.datepicker').pickadate({
      selectMonths: false,
      selectYears: false,
      clear: false,
      format: 'mmmm d, yyyy'
    });

  // Slider
   $('.slider').slider({indicators: false});

  // Activate Collapsible
  $('.collapsible-body').collapsible();

  // TypeAhead

  var customers = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('id', 'title'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    local: gon.customers
  });

  $('.typeahead').typeahead(null, {
    displayKey: 'title',
    valueKey: 'id',
    source: customers,
    highlight: true,
    hint: true,
    limit: 10,
    templates: {
      empty: [
        '<div>',
          'No customers found',
        '</div>'
      ].join('\n'),
      suggestion: function(e) { return ('<div>' + e.title + '</div>') }
    }
  });

  $('input#search').on('typeahead:autocompleted typeahead:selected', function (e, datum) {
    var customerID = datum['id'];
    $('#customer_id').val(customerID);
  });

  // Convert <address> tags to Google links
  $('address').each(function () {
    var link = "<a href='http://maps.google.com/maps?q=" + encodeURIComponent( $(this).text() ) + "' target='_blank'>" + $(this).text() + "</a>";
    $(this).html(link);
  });
});
