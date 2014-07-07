class PaperSearchesController < ApplicationController
  def search
    if params[:paper_search]
      @paper_search = PaperSearch.new(params[:paper_search]).search
      @results = policy_scope(@paper_search.results || Paper.none)
      @result_count = @results.to_a.size
      @results = @results.page(@paper_search.page).per_page(15) unless request.format.symbol == :xls
    else
      @paper_search = PaperSearch.new
    end

    respond_to do |format|
      format.html
      format.js
      format.xls {
        headers["Content-Disposition"] = "attachment; filename=\"Amaferm Research Table.xls\""
      }
    end
  end
end
