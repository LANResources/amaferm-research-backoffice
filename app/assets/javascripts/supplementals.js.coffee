$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'supplementals', 'index'
    initSummaryPopovers()
    initReferencePopovers()
    
  if pageIs 'supplementals', ['new', 'edit', 'create', 'update']
    initAuthorsAutocomplete()
    initPaperIdHelper()

initAuthorsAutocomplete = ->
  $authorInput = $('#supplemental_author_name')
  authors = $authorInput.data 'authors'
  if authors
    $authorInput.typeahead
      name: 'authors'
      local: authors

initPaperIdHelper = ->
  $(document.body).on 'change', '#supplemental_paper_id', ->
    $('.paper-id-addon').text $(this).val()

  $('#supplemental_paper_id').change()

initSummaryPopovers = ->
  $('.summary-popover').each ->
    $(this).popover
      placement: 'left'
      trigger: 'hover'

initReferencePopovers = ->
  $('.reference-popover').each ->
    $(this).popover
      placement: 'right'
      trigger: 'hover'
      html: true