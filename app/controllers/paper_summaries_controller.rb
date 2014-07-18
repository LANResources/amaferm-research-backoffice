class PaperSummariesController < ApplicationController
  before_action :set_paper_summary, only: [:edit, :update, :destroy, :download]

  def index
    @paper_summaries = PaperSummary.where(trial: policy_scope(Trial).pluck(:id)).featured.all.group_by(&:species)
  end

  def new
    @paper_summary = PaperSummary.new
    authorize! @paper_summary
  end

  def edit
  end

  def create
    @paper_summary = PaperSummary.new(paper_summary_attributes)
    authorize! @paper_summary

    if @paper_summary.save
      redirect_to featured_research_path, notice: 'Paper summary was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @paper_summary.update(paper_summary_attributes)
      redirect_to featured_research_path, notice: 'Paper summary was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @paper_summary.destroy
    redirect_to featured_research_url
  end

  def download
    send_data @paper_summary.document.file.download,
      type: @paper_summary.document.file.content_type,
      filename: @paper_summary.filename,
      disposition: 'attachment'
  end

  private
    def set_paper_summary
      @paper_summary = PaperSummary.find(params[:id])
      authorize! @paper_summary
    end

    def paper_summary_attributes
      params.require(:paper_summary).permit *policy(@paper_summary || PaperSummary).permitted_attributes
    end
end
