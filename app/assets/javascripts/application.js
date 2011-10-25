// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//= require jquery
//= require jquery-ui
//= require jquery.cuteTime
//= require jquery_ujs
//= require underscore
//= require templates


$(document).ready(function () {
  postProcessFeeds();
});


function S4() {
  return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
}
function uuid() {
  return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
}




function postProcessFeeds(){
  if ($('.timestamp') != null){
    $('.timestamp').cuteTime();
  }
}


function postComment(postId,caption){
  var request = $.ajax({
    url: "/api/posts/"+postId+"/comments",
    type: "POST",
    data: {
      caption : caption
    },
    dataType: "json",
    success: function( data ) {
      alert("worked!");
    },
    error: function(jqXHR, textStatus, errorThrown){
      alert("somesthing went terribly wrong.")
    }
  });

}

function postMedia(caption,uuid,ptype){
  if (ptype == 'photo'){
    var data = {
      caption : caption,
      uuid : uuid,
      ptype: "photo"
    };
  }else{
    var data = {
      caption : caption,
      ptype: "message"
    }
  }
  var request = $.ajax({
    url: "/api/posts",
    type: "POST",
    data: data,
    dataType: "json",
    success: function( data ) {
      alert("worked!");
    },
    error: function(jqXHR, textStatus, errorThrown){
      alert("somesthing went terribly wrong.")
    }
  });

}

function postComment(postId,caption){
  var request = $.ajax({
    url: "/api/posts/"+postId+"/comments",
    type: "POST",
    data: {
      caption : caption
    },
    dataType: "json",
    success: function( data ) {
      alert("worked!");
    },
    error: function(jqXHR, textStatus, errorThrown){
      alert("somesthing went terribly wrong.")
    }
  });

}
function postFlag(postId){
  var request = $.ajax({
    url: "/api/posts/"+postId+"/flags",
    type: "POST",
    dataType: "json",
    success: function( data ) {
      alert(postId+" flagged");
    },
    error: function(jqXHR, textStatus, errorThrown){
      alert("somesthing went terribly wrong.")
    }
  });

}

function deleteFlag(postId){
  var request = $.ajax({
    url: "/api/posts/"+postId+"/flags",
    type: "DELETE",
    dataType: "json",
    success: function( data ) {
      alert(postId+" unflagged");
    },
    error: function(jqXHR, textStatus, errorThrown){
      alert("somesthing went terribly wrong.")
    }
  });

}


function getUserPosts(user_id,divId){
  var request = $.ajax({
    url: "/api/users/"+user_id+"/posts",
    type: "GET",
    dataType: "json",
    beforeSending: function(){
      $("#"+divId).html(_loading({
        id:"loading_box"
      }));
      
    },
    success: function( data ) {
      $("#"+divId).html(_post_list({
        posts:data.response.posts.items
        }));
      postProcessFeeds();
    },
    error: function(jqXHR, textStatus, errorThrown){
      alert("somesthing went terribly wrong.")
    }
  });

}
function getUserFeed(user_id,divId){
  var request = $.ajax({
    url: "/api/users/"+user_id+"/feed",
    type: "GET",
    dataType: "json",
    beforeSending: function(){
      $("#"+divId).html(_loading({
        id:"loading_box"
      }));
      
    },
    success: function( data ) {
      $("#"+divId).html(_post_list({
        posts:data.response.posts.items
        }));
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
    data: {
      user_id: user_id
    },
    dataType: "json",
    success: function( data ) {
      
      $("#"+divId).append(_post_list({
        posts:data.response.posts
        }));
      postProcessFeeds();
    },
    error: function(jqXHR, textStatus, errorThrown){
      alert("somesthing went terribly wrong.")
    }
  });
}
function postUserFollower(user_id){
  var request = $.ajax({
    url: "/api/users/"+user_id+"/followers",
    type: "POST",
    dataType: "json",
    success: function( data ) {
      alert("worked!")
    },
    error: function(jqXHR, textStatus, errorThrown){
      alert("somesthing went terribly wrong.")
    }
  });
}
function deleteUserFollower(user_id){
  var request = $.ajax({
    url: "/api/users/"+user_id+"/followers/me",
    type: "DELETE",
    dataType: "json",
    success: function( data ) {
      alert("worked!")
    },
    error: function(jqXHR, textStatus, errorThrown){
      alert("somesthing went terribly wrong.")
    }
  });
}

function deletePost(post_id){
  var request = $.ajax({
    url: "/api/posts/"+post_id,
    type: "DELETE",
    dataType: "json",
    success: function( data ) {
      alert("worked!")
    },
    error: function(jqXHR, textStatus, errorThrown){
      alert("somesthing went terribly wrong.")
    }
  });
}








