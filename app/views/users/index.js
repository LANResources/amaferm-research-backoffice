$users = $("<%= escape_javascript(render partial: 'users/users', locals: { users: @users }) %>");
$container = $('#users-container');
$container.hide().empty().append($users).show();
