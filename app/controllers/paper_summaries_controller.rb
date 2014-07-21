class PaperSummariesController < ApplicationController
  before_action :set_paper_summary, only: [:edit, :update, :destroy, :download]

  def index
    @paper_summaries = PaperSummary.where(trial: policy_scope(Trial).pluck(:id)).featured.order(:species, :position).all.group_by(&:species)
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
      redirect_to latest_research_path, notice: 'Paper summary was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    respond_to do |format|
      format.html {
        if @paper_summary.update(paper_summary_attributes)
          redirect_to latest_research_path, notice: 'Paper summary was successfully updated.'
        else
          render action: 'edit'
        end
      }
      format.json {
        new_position = params[:reposition].try(:to_i)
        if new_position && @paper_summary.insert_at(new_position)
          render json: @paper_summary, status: :created, location: @paper_summary
        else
          render json: @paper_summary.errors, status: :unprocessable_entity
        end
      }
    end
  end

  def destroy
    @paper_summary.destroy
    redirect_to :back
  end

  def manage
    @paper_summaries = PaperSummary.includes(trial: :paper).order(:species, :position)
    authorize! @paper_summaries  
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
