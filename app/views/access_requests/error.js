$errorContainer = $('.modal').find('.form-errors');

$errors = $("<%= escape_javascript(render partial: 'shared/form_errors', locals: { resource: @access_request }) %>");
$errorContainer.empty().append($errors);
