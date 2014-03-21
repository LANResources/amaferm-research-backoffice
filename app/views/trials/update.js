$trial = $("<%= escape_javascript(render partial: 'papers/trial', locals: { trial: @trial }) %>");
$box = $('.trial-box[data-trial="<%= @trial.id %>"]');
$box.find('.trial-box-edit').hide();
$box.find('.trial-box-show').html($trial).show();
$box.find('.performance-measures-row').show();
$box.find('.trial-id').text("<%= @trial.source_sub_id %>");