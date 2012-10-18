
$(document).ready ->
  # // use AJAX to submit the "request invitation" form
  $('#invitation_button').live 'click', ->
    email  = $('form #user_email').val()
    opt_in = $('form #user_opt_in').val()
    userType   = $('form #user_type').val()
    dataString = 'user[email]='+ email + '&user[opt_in]=' + opt_in + '&user[type]=' + userType
  
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


  $('#btn-owner').live 'click', -> setUserType('Owner')

  $('#btn-vet').live 'click', -> setUserType('Vet')



setUserType = (userType) ->
  if( userType == 'Vet')
    $('form #user_type').val('Vet')
    $('span#modal-title-user-type').text('de Veterinário')
    $('form #invitation_button').removeClass('btn-success').addClass('btn-warning')
  else
    $('form #user_type').val('Owner')
    $('span#modal-title-user-type').text('de Proprietário')
    $('form #invitation_button').removeClass('btn-warning').addClass('btn-success')
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
    $.getScript "http://connect.facebook.net/en_US/all.js#xfbml=1", -> FB.init( status: true, cookie: true, xfbml: true )

  # //Google+
  if (typeof (gapi) != 'undefined')
    $(".g-plusone").each -> gapi.plusone.render($(this).get(0))
  else
    $.getScript('https://apis.google.com/js/plusone.js')

  # // Google Code for Cadastro PetCuida Conversion Page
  if $('#conversion-tracking').length > 0
    google_conversion_id = 1002155659
    google_conversion_language = "pt"
    google_conversion_format = "3"
    google_conversion_color = "ffffff"
    google_conversion_label = "gcITCOWo1gMQi93u3QM"
    google_conversion_value = 0
    $.getScript('http://www.googleadservices.com/pagead/conversion.js')

  false