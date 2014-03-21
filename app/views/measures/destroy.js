$('#edit-measure-modal').on('hidden.bs.modal', function(){ $(this).remove(); }).modal('hide');

$container = $('#performance-measures-row');
existingMeasure = $container.find('.measure-box[data-measure="<%= @measure.id %>"]').parent();
existingMeasure.fadeOut(500, function(){
  $(this).animate({width: '0px'}, 200, function(){
    $(this).remove();
  });
});
