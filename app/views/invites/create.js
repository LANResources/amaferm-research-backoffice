<% flash.each do |name, msg| %>
  $flash = $("<%= escape_javascript(render_flash name, msg) %>");
  $rowContent = $('<div></div>').addClass('col-md-12');
  $row = $('<div></div>').addClass('row');
  $rowContent.append($flash);
  $row.append($rowContent);
  $('#content').prepend($row);
<% end %>