$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'sales_aids', ['new', 'create', 'edit', 'update']
    initForm()

initForm = ->
  showFields = (types) ->
    types = [types] unless $.isArray types
    for type in types
      $(".#{type}-type").show()

  hideFields = (types) ->
    types = [types] unless $.isArray types
    for type in types
      ($el = $(".#{type}-type")).hide()
      $el.find('input').val('') if type in ['calculator', 'video']

  $(document.body).on 'change', 'select.category-select', ->
    category = $(this).val()
    switch category
      when 'video'
        hideFields ['document', 'calculator']
        showFields 'video'
      when 'calculator'
        hideFields ['document', 'video']
        showFields 'calculator'
      else
        hideFields ['video', 'calculator']
        showFields 'document'

  $('select.category-select').change()
