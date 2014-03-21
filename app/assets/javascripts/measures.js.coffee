$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'trials', ['edit', 'update']
    initMeasureEditing()

initMeasureEditing = ->
  $(document.body).on 'click', '.measure-box.editable', ->
    $.getScript $(this).data('path')