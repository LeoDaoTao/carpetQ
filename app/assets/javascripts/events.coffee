$ ->
  numToTel = (phones) ->
    for phone in phones 
      "<p><a href='tel:#{phone[0]}'>#{formatTel(phone[0])}</a> #{phone[1]}</p>"

  formatTel = (number) ->
    number.replace(/(\d\d\d)(\d\d\d)(\d\d\d\d)/, '($1) $2-$3')

  $('#calendar').fullCalendar
    header:
      left: 'prev,next today'
      center: 'title'
      right: 'month,agendaWeek,agendaDay'
    defaultDate: gon.date
    editable: false
    slotEventOverlap: false
    eventLimit: false
    allDaySlot: false
    height: "auto"
    minTime: "06:00:00"
    maxTime: "21:00:00"
    timeFormat: ' '
    defaultView: "agendaWeek"
    eventBorderColor: "#313131"
    events: gon.events
    eventRender: (event, element) ->
      element.click ->
        $('#modal-customer-name').text(event.title)
        $('#modal-edit-btn').attr('href', event.edit_url)
        $('#modal-date').text(event.date)
        $('#modal-time').text(event.time)
        $('#modal-phones').html(numToTel(event.phones))
        $('#modal-address').text(event.address)
        $('address').each ->
          link = '<a href=\'http://maps.google.com/maps?q=' + encodeURIComponent($(this).text()) + '\' target=\'_blank\'>' + $(this).text() + '</a>'
          $(this).html link
          return
        $invoiceBtn = $('#modal-invoice-btn')
        if event.invoice_id != null
          $invoiceBtn.html 'Edit Invoice'
          $invoiceBtn.attr 'href', '/invoices/' + event.invoice_id + '/edit'
        else
          $invoiceBtn.html 'Create Invoice'
          $invoiceBtn.attr 'href', '/invoices/new?event_id=' + event.id
        $('#event-modal').openModal()
        return
      element.find('.fc-title').append("<br>[" + event.city + "]") if event.city
      return
    dayClick: (date) ->
      window.location = '/events/new?start_time=' + encodeURIComponent(date.format())
      return
