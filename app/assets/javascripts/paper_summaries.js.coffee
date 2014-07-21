$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'paper_summaries', 'manage'
    initDescriptionPopovers()
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
    $row.insertBefore $swapRow
    $row.data('position', newPosition).find('.position').text(newPosition)
    $swapRow.data('position', currentPosition).find('.position').text(currentPosition)

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
  species = $row.data 'species'
  $speciesRows = $('tr[data-species="' + species + '"]')
  unless currentPosition is $speciesRows.size()
    url = $row.data 'update-url'
    newPosition = currentPosition + 1
    $swapRow = $row.next 'tr'
    $row.insertAfter $swapRow
    $row.data('position', newPosition).find('.position').text(newPosition)
    $swapRow.data('position', currentPosition).find('.position').text(currentPosition)

    data = "reposition=" + newPosition
    $.ajax
      type: "PUT"
      dataType: 'json'
      url: url
      data: data
