
$(document).ready ->
  # // use AJAX to submit the "request invitation" form
  $('#invitation_button').live 'click', ->
    email = $('form #user_email').val()
    if($('form #user_opt_in').is(':checked'))
        opt_in = true
    else
        opt_in = false
    type = $('form #user_type').val()
    dataString = 'user[email]='+ email + '&user[opt_in]=' + opt_in + '&user[type]=' + type

    $.ajax(
      type: "POST"
      url: "/users"
      data: dataString
      success: (data) ->
        $('#request-invite').html(data)
        loadSocial()
    )
    false

  $('#btn-owner').live 'click', ->
    $('form #user_type').val('Owner')

  $('#btn-vet').live 'click', ->
    $('form #user_type').val('Vet')


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
