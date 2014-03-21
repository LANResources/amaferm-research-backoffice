$('#edit-measure-modal').on('hidden.bs.modal', function(){ $(this).remove(); }).modal('hide');

$container = $('#performance-measures-row');
updatedMeasure = $("<%= escape_javascript(render partial: 'measures/measure', locals: { measure: @measure }) %>");
existingMeasure = $container.find('.measure-box[data-measure="<%= @measure.id %>"]').parent();
existingMeasure.fadeOut(500, function(){
  $(this).replaceWith(updatedMeasure).fadeIn(500);
});
