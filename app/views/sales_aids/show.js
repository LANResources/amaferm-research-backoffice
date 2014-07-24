id = "#sales-aid-video-modal"
$(id).remove();
$videoModal = $("<%= escape_javascript(render partial: 'sales_aids/video_modal', locals: { sales_aid: @sales_aid }) %>");
$('#content').append($videoModal);
$(id).modal('show');
$(id).on('hidden.bs.modal', function(){ $(this).remove(); });
