// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function postComment(caption){
  var request = $.ajax({
    url: "/posts",
    type: "POST",
    data: {caption : caption,
           ptype: "message"},
    dataType: "html",
    success: function( data ) {
      alert("worked!");
    },
    error: function(jqXHR, textStatus, errorThrown){
      alert("somesthing went terribly wrong.")
    }
  });

}