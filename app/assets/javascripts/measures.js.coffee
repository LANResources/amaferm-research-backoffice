$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs('trials', ['show', 'edit', 'update']) or pageIs('papers', 'show')
    initMeasureEditing()

initMeasureEditing = ->
  $(document.body).on 'click', '.measure-box.editable', ->
    $.getScript $(this).data('path')
