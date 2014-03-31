class TrialsController < ApplicationController
  before_action :set_paper, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :set_trial, only: [:show, :edit, :update, :destroy]
  before_action :scope_trials, only: :index

  def index
    respond_to do |format|
      format.html { @trials = @trials.page(params[:page]).per_page(15) }
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"Amaferm Research Table.xls\"" }
    end
  end

  def show
    render 'papers/show'
  end

  def new
    @trial = @paper.trials.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @trial = @paper.trials.build trial_attributes

    respond_to do |format|
      if @trial.save
        format.html { redirect_to @paper, notice: 'Trial was successfully created.' }
        format.js
      else
        format.html { render action: 'new' }
        format.js { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @trial.update(trial_attributes)
        format.html { redirect_to @paper, notice: 'Trial was successfully updated.' }
        format.js
      else
        format.html { render action: 'edit' }
        format.js { render action: 'edit' }
      end
    end
  end

  def destroy
    @trial.destroy
    respond_to do |format|
      format.html { redirect_to @paper }
      format.js
    end
  end

  private
    def set_paper
      @paper = Paper.find params[:paper_id] if params[:paper_id]
    end

    def set_trial
      @trial = current_resource
      authorize! @trial
    end

    def current_resource
      if params[:action] == 'create'
        @current_resource ||= params[:trial] if params[:trial]
      else
        @current_resource ||= @paper.trials.where(source_sub_id: params[:id]).first if params[:id]
      end
    end

    def trial_attributes
      params.require(:trial).permit *policy(@trial || Trial).permitted_attributes
    end

    def scope_trials
      redirect_to paper_path(params[:paper_id]) if params[:paper_id]

      @trials = Trial.filter(params.slice(:species, :focus, :author, :journal), :with_paper_and_author)
      @trials = policy_scope @trials.order("#{sort_column} #{sort_direction}").order('year asc')
    end

    def sort_column
      super(Trial.column_names + ['papers.title', 'papers.journal'], 'year')
    end

    def sort_direction(default = 'desc')
      super(default)
    end
end
