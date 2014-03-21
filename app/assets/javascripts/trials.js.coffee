$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'trials', 'index'
    initTrialFilter()
    initSummaryPopovers()
    initReferencePopovers()

  if pageIs 'trials', ['new', 'edit', 'create', 'update']
    initTrialForm()

initTrialFilter = ->
  $(document.body).on 'change', '#trial_filter select', ->
    $form = $('#trial_filter')
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

initReferencePopovers = ->
  $('.reference-popover').each ->
    $(this).popover
      placement: 'right'
      trigger: 'hover'
      html: true

initTrialForm = ->
  initSpeciesAutocomplete()
  initTagsInput()

initSpeciesAutocomplete = ->
  $speciesInput = $('.species-autocomplete')
  species = $speciesInput.data 'species'
  if species
    $speciesInput.typeahead
      name: 'species'
      local: species

initTagsInput = ->
  for $tagsInput in [$('.calculations-select2'), $('.focuses-select2')]
    tags = $tagsInput.data 'tags'
    $tagsInput.select2
      tags: tags
      tokenSeparators: [',']
