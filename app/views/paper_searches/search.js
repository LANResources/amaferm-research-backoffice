$results = $("<%= escape_javascript(render partial: 'paper_searches/results', locals: { results: @results, result_count: @result_count }) %>");
$('#results').html($results);
$('#new_paper_search').parents('.box').find('h2 i').replaceWith($('<i class="fa fa-search"></i>'));
$('.reset-search').fadeIn();
