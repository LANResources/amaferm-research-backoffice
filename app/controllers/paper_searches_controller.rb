require 'will_paginate/array'

class PaperSearchesController < ApplicationController
  def lookup
    if (result = PaperSearch.lookup params[:q])
      location = result.is_a?(Trial) ? paper_trial_path(result.paper, result) : paper_path(result)
    else
      flash[:error] = "Unable to find paper/trial with that number."
      location = request.headers["Referer"]
      location = trials_path if location.blank?
    end

    respond_to do |format|
      format.html { redirect_to location }
      format.js { redirect_via_turbolinks_to location }
    end
  end

  def search
    if params[:paper_search]
      @paper_search = PaperSearch.new(params[:paper_search]).search
      @results = policy_scope(@paper_search.results || Paper.none)
      @result_count = @results.to_a.size
      @results = @results.to_a.paginate(page: @paper_search.page, per_page: 15) unless request.format.symbol == :xls
    else
      @paper_search = PaperSearch.new
    end

    respond_to do |format|
      format.html
      format.js
      format.xls {
        headers["Content-Disposition"] = "attachment; filename=\"Research Center Table.xls\""
      }
    end
  end
end
