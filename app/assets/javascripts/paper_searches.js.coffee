$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'paper_searches'
    initPaperSearchForm()
    initDetailsToggle()

initPaperSearchForm = ->
  $(document.body).on 'submit', '#new_paper_search', ->
    $(this).parents('.box').find('h2 i').replaceWith($('<i class="fa fa-spinner fa-spin"></i>'));

  $(document.body).on 'change', '#new_paper_search input', ->
    $('#new_paper_search').submit()

initDetailsToggle = ->
  $(document.body).on 'click', '.details-toggle', ->
    $(this).parents('.panel').find('.detail-table').toggle()
    $icon = $(this).find('i')
    if $icon.hasClass 'fa-plus-square-o'
      $icon.removeClass('fa-plus-square-o').addClass('fa-minus-square-o')
    else
      $icon.removeClass('fa-minus-square-o').addClass('fa-plus-square-o')
