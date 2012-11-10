
$(document).ready ->
  # // use AJAX to submit the "request invitation" form
  $('#invitation_button').live 'click', ->
    email  = $('form #user_email').val()
    opt_in = $('form #user_opt_in').val()
    userType   = $('form #user_type').val()
    # dataString = 'user[email]='+ email + '&user[opt_in]=' + opt_in + '&user[type]=' + userType
    dataString = $("#new_user").serialize()
    $.ajax(
      type: "POST"
      url: "/users"
      data: dataString
      success: (data) ->
        $('#request-invite').html(data)
        setUserType(userType)
        loadSocial()
    )
    false


# // load social sharing scripts if the page includes a Twitter "share" button
loadSocial = ->
  # //Twitter
  if (typeof (twttr) != 'undefined')
    twttr.widgets.load()
  else 
    $.getScript('http://platform.twitter.com/widgets.js')

  # //Facebook
  if (typeof (FB) != 'undefined')
    FB.init( status: true, cookie: true, xfbml: true )
  else
    $.getScript "http://connect.facebook.net/pt_BR/all.js#xfbml=1", -> FB.init( status: true, cookie: true, xfbml: true )

  # //Google+
  window.___gcfg = {lang: 'pt-BR'}
  if (typeof (gapi) != 'undefined')
    $(".g-plusone").each -> gapi.plusone.render($(this).get(0))
  else
    $.getScript('https://apis.google.com/js/plusone.js')

  # // Google Code for Cadastro PetCuida Conversion Page
  if $('#conversion-tracking').length > 0
    window.google_conversion_id = 1002155659
    window.google_conversion_language = "pt"
    window.google_conversion_format = "3"
    window.google_conversion_color = "ffffff"
    window.google_conversion_label = "gcITCOWo1gMQi93u3QM"
    window.google_conversion_value = 0
    
    document.write = (text) ->
      $('#conversion-tracking').append(text)

    $.getScript('http://www.googleadservices.com/pagead/conversion.js')

  false
