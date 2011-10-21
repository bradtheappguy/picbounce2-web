// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//= require underscore
//= require templates
//= require jquery
//= require jquery.cuteTime
//= require jquery_ujs
//= require_self


$(document).ready(function () {
  postProcessFeeds();
  //getFeedAfter("Domix23","2010-09-26T07:06:41Z","posts");
  //getFeed("Domix23","posts");
});

function postProcessFeeds(){
  if ($('.timestamp') != null){
    $('.timestamp').cuteTime();
  }
}


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
function getFeed(user_id,divId){
  var request = $.ajax({
    url: "/api/users/"+user_id+"/feed",
    type: "GET",
    dataType: "json",
    beforeSending: function(){
      $("#"+divId).html(_loading({id:"loading_box"}));
      
    },
    success: function( data ) {
      
      $("#"+divId).html(_post_list({posts:data.response.posts}));
      postProcessFeeds();
    },
    error: function(jqXHR, textStatus, errorThrown){
      alert("somesthing went terribly wrong.")
    }
  });

}

function getFeedAfter(user_id,after,divId){
  var request = $.ajax({
    url: "/api/feed",
    type: "GET",
    data: {user_id: user_id
             },
    dataType: "json",
    success: function( data ) {
      
      $("#"+divId).append(_post_list({posts:data.response.posts}));
      postProcessFeeds();
    },
    error: function(jqXHR, textStatus, errorThrown){
      alert("somesthing went terribly wrong.")
    }
  });
}







/*
 * jQuery File Upload Plugin JS Example 5.0.2
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://creativecommons.org/licenses/MIT/
 */

/*jslint nomen: true */
/*global $ */


/*
   $(function () {
    'use strict';

    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload();

    // Load existing files:
    $.getJSON($('#fileupload form').prop('action'), function (files) {
        var fu = $('#fileupload').data('fileupload');
        fu._adjustMaxNumberOfFiles(-files.length);
        fu._renderDownload(files)
            .appendTo($('#fileupload .files'))
            .fadeIn(function () {
                // Fix for IE7 and lower:
                $(this).show();
            });
    });

    // Open download dialogs via iframes,
    // to prevent aborting current uploads:
    $('#fileupload .files a:not([target^=_blank])').live('click', function (e) {
        e.preventDefault();
        $('<iframe style="display:none;"></iframe>')
            .prop('src', this.href)
            .appendTo('body');
    });

  });

*/