$form = $("<%= escape_javascript(render partial: 'trials/form', locals: { trial: @trial, remote: true }) %>");
$box = $('.trial-box[data-trial="<%= @trial.id %>"]');
$box.find('.trial-box-show, .performance-measures-row').hide();
$box.find('.trial-box-edit').html($form).show();
$box.find('.cancel-btn').click(function(e){
  e.preventDefault();
  $boxContent = $(this).parents('.box-content');
  $boxContent.find('.trial-box-edit').hide();
  $boxContent.find('.trial-box-show').show();
});

window._initPaperForm();