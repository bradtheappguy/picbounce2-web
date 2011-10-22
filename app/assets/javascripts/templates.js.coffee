//= require underscore

window._photo = _.template('
        
  <div class="profile_pic_post left">
    <a href="/users/<%= photo.user.id %>" ><img src="<%= photo.user.avatar %>" with="50" height="50" /></a>
  </div>
  <div class="left details">
    <div class="post_titles">
      <h3 class="left">
        <a href="/users/<%= photo.user.id %>"><%= photo.user.screen_name  %></a>
      </h3>
      <small class="left"><span class="timestamp"><%=photo.created%></span></small>
    </div>

    <p class="left post_titles"><%=photo.caption%></p>
    <a href="/posts/<%= photo.code %>" ><img src="<%= photo.media_url %>" with="100" height="100" /></a>
  </div>

  <div class="comments">
    <ul class="left">
      <% for (i in photo.comments) {%>
        <li class="left">   
          <%= _post_comment({ comment: photo.comments[i].comment }) %>
        </li>
       <%}%>
    </ul>

  </div>

')

window._message = _.template('
  
  <div class="profile_pic_post left">
    <a href="/users/<%= message.user.id %>" ><img src="<%= message.user.avatar %>" with="50" height="50" /></a>
  </div>
  <div class="left details">
      <h3 class="left">
        <a href="/users/<%= message.user.id %>"><%= message.user.screen_name  %></a>
      </h3>
      <small class="left"><span class="timestamp"><%=message.created%></span></small>
      <br class="clear"/>
      <p><%=message.caption%></p>
      <a href="javascript:deletePost(\'<%- message.code%>\')" >delete </a>

    
  </div>

  <div class="comments">
    <ul class="left">
      <% for (i in message.comments) {%>
        <li class="left">      
          <%= _post_comment({ comment: message.comments[i].comment }) %>
        </li>
       <%}%>
    </ul>

  </div>

')



window._post_comment = _.template('

  <div class="profile_pic left">
    <a href="/users/<%= comment.user.id %>" ><img src="<%= comment.user.avatar %>" with="50" height="50" /></a>
  </div>
  <div class="left post_details">
    <h3 class="left">
      <a href="/users/<%= comment.user.id %>"><%= comment.user.screen_name  %></a>
    </h3>
    <small class="left"><span class="timestamp"><%=comment.created_at%></span></small>
    <br class="clear"/>
    <p ><%=comment.caption%></p>
  </div>

')

window._post_list = _.template('
    <% for (i in posts) { %>
        <li class="left">
         <% if (posts[i].post.ptype == "photo"){ %>
            <%= _photo({ photo: posts[i].post}) %>
        <%}else{%>
            <%= _message({ message: posts[i].post}) %>
        <%}%>
        <li>
   <%}%>
  
');


window._loading = _.template('
  <span id="<%=id%>">loading...</span>
');
