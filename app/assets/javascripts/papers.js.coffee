$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'papers', ['new', 'edit', 'create', 'update']
    _initPaperForm()

window._initPaperForm = ->
  initAuthorsAutocomplete()
  initJournalsAutocomplete()
  initTagsInput()
  initPaperIdHelper()

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
  for $tagsInput in [$('.species-select2'), $('.calculations-select2'), $('.focuses-select2')]
    tags = $tagsInput.data 'tags'
    $tagsInput.select2
      tags: tags
      tokenSeparators: [',']

initPaperIdHelper = ->
  $(document.body).on 'change', '#paper_source_id', ->
    $('.paper-id-addon').text $(this).val()

  $('#paper_source_id').change()
