$trials = $("<%= escape_javascript(render partial: 'trials/trials', locals: { trials: @trials }) %>");
$container = $('#trials-container');
$container.hide().empty().append($trials).fadeIn();