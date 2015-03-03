$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'pages', 'welcome'
    hideMenu()
  else if localStorage.mainMenuPreference is 'open'
    $('#sidebar-left').show()

hideMenu = ->
  unless localStorage.mainMenuPreference is 'closed'
    $('#main-menu-toggle').click()
    localStorage.mainMenuPreference = 'open'
