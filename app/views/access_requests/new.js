id = "#access-request-modal"
$(id).remove();
$accessRequestModal = $("<%= escape_javascript(render partial: 'access_requests/access_request_modal') %>");
$('#content').append($accessRequestModal);
$(id).modal('show');
