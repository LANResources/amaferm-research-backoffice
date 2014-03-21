$('#edit-measure-modal').on('hidden.bs.modal', function(){ $(this).remove(); }).modal('hide');

if (pageIs('trials', ['edit', 'update'])){
  $container = $('#performance-measures-row');
}else if (pageIs('papers', 'show')){
  $container = $('.trial-box[data-trial="<%= @measure.trial_id %>"]').find('.performance-measures-row');
}else{
  $container = false;
}

if ($container){
  updatedMeasure = $("<%= escape_javascript(render partial: 'measures/measure', locals: { measure: @measure, editable: true }) %>");
  existingMeasure = $container.find('.measure-box[data-measure="<%= @measure.id %>"]').parent();
  existingMeasure.fadeOut(500, function(){
    $(this).replaceWith(updatedMeasure).fadeIn(500);
  });
}
