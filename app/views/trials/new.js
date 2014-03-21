<% if params[:action] == 'create' %>
  $form = $("<%= escape_javascript(render partial: 'trials/form', locals: { trial: @trial, remote: true }) %>");
  $box = $('.new-trial-box');
  $box.find('.trial-box-edit').html($form).show();
  $box.find('.cancel-btn').click(function(e){
    e.preventDefault();
    $box = $(this).parents('.box');
    $box.fadeOut(500, function(){
      $(this).remove();
    });
  });
<% else %>
  $box = $("<%= escape_javascript(render partial: 'trials/new_trial_box_row', locals: { trial: @trial, remote: true }) %>");
  $lastTrial = $('.trial-box').last();
  $box.hide().insertAfter($lastTrial);
  $box.show();
  $box.find('.cancel-btn').click(function(e){
    e.preventDefault();
    $box = $(this).parents('.box');
    $box.fadeOut(500, function(){
      $(this).remove();
    });
  });
<% end %>

window._initPaperForm();