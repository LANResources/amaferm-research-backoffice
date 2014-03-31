id = "#new-feedback-modal"
$(id).remove();
$feedbackModal = $("<%= escape_javascript(render partial: 'feedback/feedback_modal') %>");
$('#content').append($feedbackModal);
$(id).modal('show');
