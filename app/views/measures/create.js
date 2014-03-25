$('#new-measure-modal').on('hidden.bs.modal', function(){ $(this).remove(); }).modal('hide');

if (pageIs('trials', ['edit', 'update'])){
  $container = $('#performance-measures-row');
}else if (pageIs('papers', 'show') || pageIs('trials', 'show')){
  $container = $('.trial-box[data-trial="<%= @measure.trial_id %>"]').find('.performance-measures-row');
}else{
  $container = false;
}

if ($container){
  newMeasure = $("<%= escape_javascript(render partial: 'measures/measure', locals: { measure: @measure, editable: true }) %>");
  newMeasure.hide().insertBefore($container.find('.new-performance-measure-btn-container'));

  newMeasure.fadeIn();
}
