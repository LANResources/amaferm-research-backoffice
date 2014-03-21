$trialBox = $("<%= escape_javascript(render partial: 'papers/trial_box', locals: { trial: @trial, spotlight: false }) %>");
$('.new-trial-box').hide().replaceWith($trialBox);
$box = $('.trial-box[data-trial="<%= @trial.id %>"]');
$box.find('.trial-box-edit').hide();
$box.show();