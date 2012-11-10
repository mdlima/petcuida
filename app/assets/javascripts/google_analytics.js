var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-34887240-1']);
_gaq.push(['_setSiteSpeedSampleRate', 100]);
_gaq.push(['_trackPageview']);

// (function() {
//   var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
//   ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
//   var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
// })();


jQuery.externalScript = function(url, options) {
  // allow user to set any option except for dataType, cache, and url
  options = $.extend(options || {}, {
    dataType: "script",
    cache: true,
    url: url
  });
  // Use $.ajax() since it is more flexible than $.getScript
  // Return the jqXHR object so we can chain callbacks
  return jQuery.ajax(options);
};

ga_src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
$.externalScript(ga_src).done(function(script, textStatus) {
  // console.log('Script loading: ' + textStatus );
  if (typeof _gat != 'undefined') {
    // console.log('Okay. GA file loaded.');
  }
  else
  {
    console.log('Problem. GA file not loaded.');
  }
});
