$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'trials', 'index'
    fetchTrials()
    initTrialFilter()
    initSummaryPopovers()
    initReferencePopovers()

  if pageIs 'trials', ['new', 'edit', 'create', 'update']
    initTrialForm()

fetchTrials = ->
  $container = $('#trials-container')
  url = $container.data 'url'
  $.getScript url, ->
    initSummaryPopovers()
    initReferencePopovers()

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
  initTagsInput()

initTagsInput = ->
  for $tagsInput in [$('.species-select2'), $('.calculations-select2'), $('.focuses-select2')]
    tags = $tagsInput.data 'tags'
    $tagsInput.select2
      tags: tags
      tokenSeparators: [',']
