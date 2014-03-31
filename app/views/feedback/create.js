$('#new-feedback-modal').on('hidden.bs.modal', function(){ $(this).remove(); }).modal('hide');

$flash = $("<%= escape_javascript(render_flash('success', 'Your feedback has been successfully submitted.')) %>");
$('#flash').hide().html($flash).fadeIn();
