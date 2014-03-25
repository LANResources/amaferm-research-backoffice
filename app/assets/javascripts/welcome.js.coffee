$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'pages', 'welcome'
    hideMenu()

hideMenu = ->
  $('#main-menu-toggle').click()
  localStorage.mainMenuPreference = 'open'
