$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'paper_summaries', 'manage'
    initDescriptionPopovers()

  if pageIs('paper_summaries', 'manage') or pageIs('sales_aids', 'manage')
    initPositionButtons()

initDescriptionPopovers = ->
  $('.description-popover').each ->
    $(this).popover
      placement: 'bottom'
      trigger: 'hover'

initPositionButtons = ->
  $(document.body).on 'click', '.inc-position-btn', incrementPosition
  $(document.body).on 'click', '.dec-position-btn', decrementPosition

incrementPosition = (e) ->
  e.preventDefault()
  $row = $(this).parents('tr').first()
  currentPosition = $row.data 'position'
  unless currentPosition is 1
    url = $row.data 'update-url'
    newPosition = currentPosition - 1
    $swapRow = $row.prev 'tr'
    $row.addClass 'success'
    $row.fadeOut 500, ->
      $row.data('position', newPosition).find('.position').text(newPosition)
      $swapRow.data('position', currentPosition).find('.position').text(currentPosition)
      $row.insertBefore($swapRow).fadeIn 500, ->
        setTimeout (->
          $row.removeClass 'success'
        ), 1000

    data = "reposition=" + newPosition
    $.ajax
      type: "PUT"
      dataType: 'json'
      url: url
      data: data

decrementPosition = (e) ->
  e.preventDefault()
  $row = $(this).parents('tr').first()
  currentPosition = $row.data 'position'
  groups = $row.data 'group'
  $groupedRows = $('tr[data-group="' + groups + '"]')
  unless currentPosition is $groupedRows.size()
    url = $row.data 'update-url'
    newPosition = currentPosition + 1
    $swapRow = $row.next 'tr'
    $row.addClass 'success'
    $row.fadeOut 500, ->
      $row.data('position', newPosition).find('.position').text(newPosition)
      $swapRow.data('position', currentPosition).find('.position').text(currentPosition)
      $row.insertAfter($swapRow).fadeIn 500, ->
        setTimeout (->
          $row.removeClass 'success'
        ), 1000
    
    data = "reposition=" + newPosition
    $.ajax
      type: "PUT"
      dataType: 'json'
      url: url
      data: data
