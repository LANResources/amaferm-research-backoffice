$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'users', 'index'
    initSearchForm()

initSearchForm = ->
  $(document.body).on 'submit', '#user-search-form', (e) ->
    e.preventDefault()
    q = $('#user-search-term').val()
    q = if q.length > 0 then "?q=#{q}" else ""
    Turbolinks.visit "/users#{q}"

  $(document.body).on 'input', '#user-search-term', ->
    q = $(this).val()
    q = if q.length > 0 then "?q=#{q}" else ""
    $.getScript "/users#{q}"


