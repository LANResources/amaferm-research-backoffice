$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'papers', 'index'
    initPaperFilter()
    initSummaryPopovers()

  if pageIs 'papers', ['new', 'edit', 'create', 'update']
    initPaperForm()

initPaperFilter = ->
  $(document.body).on 'change', '#paper_filter select', ->
    $form = $('#paper_filter')
    fields = $form.serialize().split('&')
    fields = (field for field in fields when /^(species|focus|author|journal)=\S+$/i.test(field)).join('&')
    url = $form.attr 'action'
    url += "?#{fields}" if fields.length > 0
    Turbolinks.visit url

initSummaryPopovers = ->
  $('.summary-popover').each ->
    $(this).popover
      placement: 'left'
      trigger: 'hover'

initPaperForm = ->
  initAuthorsAutocomplete()
  initJournalsAutocomplete()
  initTagsInput()

initAuthorsAutocomplete = ->
  $authorInput = $('#paper_author_name')
  authors = $authorInput.data 'authors'
  if authors
    $authorInput.typeahead
      name: 'authors'
      local: authors

initJournalsAutocomplete = ->
  $journalInput = $('#paper_journal')
  journals = $journalInput.data 'journals'
  if journals
    $journalInput.typeahead
      name: 'journals'
      local: journals

initTagsInput = ->
  for $tagsInput in [$('#paper_species_list'), $('#paper_focus_list')]
    tags = $tagsInput.data 'tags'
    $tagsInput.select2
      tags: tags
      tokenSeparators: [',']
