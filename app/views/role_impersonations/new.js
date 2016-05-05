$('#impersonation-modal').remove()
$modal = $("<%= escape_javascript(render partial: 'role_impersonations/modal') %>");
$modal.modal('show');
