$results = $("<%= escape_javascript(render partial: 'paper_searches/results', locals: { results: policy_scope(@paper_search.results) }) %>");
$('#results').html($results);
$('#new_paper_search').parents('.box').find('h2 i').replaceWith($('<i class="fa fa-search"></i>'));