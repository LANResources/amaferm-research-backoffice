$box = $('.trial-box[data-trial="<%= @trial.id %>"]');
$box.parents('.row').first().remove();