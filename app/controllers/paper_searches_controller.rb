class PaperSearchesController < ApplicationController
  def search
    @paper_search = if params[:paper_search]
                      PaperSearch.new(params[:paper_search]).search
                    else
                      PaperSearch.new
                    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end
