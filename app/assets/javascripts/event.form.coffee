$ ->
  # Hide typeahead dd on page refresh
  $('.typeahead').typeahead('close')
  
  # Add 2 hours on start time change
  $("#event_time_start").on 'change', ->
    startTime = moment(@value, 'HH:mma')
    startTime.add(2, 'hours')
    endTime = startTime.format('h:mma')
    $("#event_time_end").val(endTime).material_select()
    updateAddCustomerLink()

  $("#event_date").on 'change', ->
    updateAddCustomerLink()

  $("#event_time_end").on 'change', ->
    updateAddCustomerLink()

  # Render New Client Date/Time Link on Date or time changes
  
  updateAddCustomerLink = ->
    eventDate = $("#event_date").val()
    eventDate = moment(eventDate, 'D MMMM, YYYY')
    eventDate = eventDate.format('YYYY-MM-DD')

    eventTimeStart = $("#event_time_start").val()
    eventTimeStart = moment(eventTimeStart, 'HH:mma')
    eventTimeStart = eventTimeStart.format('HH:mm')

    eventTimeEnd = $("#event_time_end").val()
    eventTimeEnd = moment(eventTimeEnd, 'HH:mma')
    eventTimeEnd = eventTimeEnd.format('HH:mm')

    addCustomerLink = '/customers/new?start_time=' + eventDate + 'T' + encodeURIComponent(eventTimeStart) + '&end_time=' + encodeURIComponent(eventTimeEnd)
    $("#add-customer-link").attr('href', addCustomerLink)

  $("#button").click (event)->
    event.preventDefault()
    updateAddCustomerLink()
