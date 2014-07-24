$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'sales_aids', ['new', 'create', 'edit', 'update']
    initForm()

initForm = ->
  $(document.body).on 'change', 'select.category-select', ->
    category = $(this).val()
    if category is 'video'
      $('.document-type').hide()
      $('.video-type').show()
    else
      $('.document-type').show()
      $('.video-type').hide()

  $('select.category-select').change()