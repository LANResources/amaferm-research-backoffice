$('#new-measure-modal').on('hidden.bs.modal', function(){ $(this).remove(); }).modal('hide');

$container = $('#performance-measures-row');
newMeasure = $("<%= escape_javascript(render partial: 'measures/measure', locals: { measure: @measure }) %>");
newMeasure.hide().insertBefore($container.find('#new-performance-measure-btn-container'));

newMeasure.fadeIn();
