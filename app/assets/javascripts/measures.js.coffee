$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs('trials', ['show', 'edit', 'update']) or pageIs('papers', 'show')
    initMeasureEditing()
    setMeasureHeights()
    $(window).on 'resize', setMeasureHeights

initMeasureEditing = ->
  $(document.body).on 'click', '.measure-box.editable', ->
    $.getScript $(this).data('path')

setMeasureHeights = ->
  $('.trial-box').each ->
    measures = $(this).find('.measure-container')
    if measures.length > 1
      maxHeight = Math.max.apply null, ($(measure).height() for measure in measures)
      ($measure = $(measure)).css 'paddingBottom', maxHeight - $measure.height() for measure in measures
