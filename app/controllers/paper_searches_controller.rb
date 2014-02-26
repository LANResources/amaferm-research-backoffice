class PaperSearchesController < ApplicationController
  def search
    @paper_search = if params[:paper_search]
                      PaperSearch.new(params[:paper_search]).search
                    else
                      PaperSearch.new
                    end

    respond_to do |format|
      format.html {
        @years = Paper.pluck(:year).uniq.sort
        @authors = Author.pluck(:last_name).sort
      }
      format.js
    end
  end
end
