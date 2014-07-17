$('#access-request-modal').on('hidden.bs.modal', function(){ $(this).remove(); }).modal('hide');

$flash = $("<%= escape_javascript(render_flash('success', 'Your access request has been successfully submitted.')) %>");
$('#flash').hide().html($flash).fadeIn();
