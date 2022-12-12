$ ->
  reminderDate = $('#invoice_reminder_date')

  $('#reminder-3m').click (event) ->
    event.preventDefault()
    reminder = moment(Date.now())
    reminder = reminder.add(3, 'months')
    reminder = reminder.format('D MMMM, YYYY')
    reminderDate.val(reminder)
  $('#reminder-6m').click (event) ->
    event.preventDefault()
    reminder = moment(Date.now())
    reminder = reminder.add(6, 'months')
    reminder = reminder.format('D MMMM, YYYY')
    reminderDate.val(reminder)
  $('#reminder-1y').click (event) ->
    event.preventDefault()
    reminder = moment(Date.now())
    reminder = reminder.add(1, 'year')
    reminder = reminder.format('D MMMM, YYYY')
    reminderDate.val(reminder)

  $('#invoice-items').bind 'cocoon:after-insert', (e, insertedItem) ->
    insertedItem.find('.material-select').material_select()

    $('.total-cost').bind 'blur input', ->
      calculateTotal()
      return

  #$('a.add_fields').click()

  $('#invoice-items').bind 'cocoon:after-remove', (e, insertedItem) ->
    calculateTotal()
  
  $('#invoice_discount_id').change ->
    calculateTotal()

  # Functions ///////////////////////////////
  
  calculateSubTotal = ->
    sum = 0
    $('.total-cost').each ->
      sum += Number($(this).val())
    $('#sub-total').val(formatCurrency(sum))
    sum

  calculateTotal = ->
    discount = $('#invoice_discount_id').find(':selected').data('discount')
    discount = discount || 0
    subTotal = calculateSubTotal()
    total = subTotal - discount
    total = formatCurrency(total)
    $('#invoice_total').val(total)
 
  formatCurrency = (num) ->
    num = num.toString().replace(/\$|\,/g, '')
    if isNaN(num)
      num = '0'
    sign = num == (num = Math.abs(num))
    num = Math.floor(num * 100 + 0.50000000001)
    cents = num % 100
    num = Math.floor(num / 100).toString()
    if cents < 10
      cents = '0' + cents
    i = 0
    while i < Math.floor((num.length - (1 + i)) / 3)
      num = num.substring(0, num.length - (4 * i + 3)) + ',' + num.substring(num.length - (4 * i + 3))
      i++
    num + '.' + cents

