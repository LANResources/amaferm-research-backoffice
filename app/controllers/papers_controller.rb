class PapersController < ApplicationController
  before_action :set_paper, only: [:show, :edit, :update, :destroy, :download]
  before_action :scope_papers, only: :index

  def index
  end

  def show
  end

  def new
    @paper = Paper.new
  end

  def edit
  end

  def create
    @author = Author.find_or_create_from params[:paper][:author_name]
    @paper = @author.papers.build paper_attributes

    respond_to do |format|
      if @paper.save
        format.html { 
          if params[:commit] == 'Create and Add Another'
            redirect_to new_paper_path, notice: ['Paper was successfully created.', view_context.link_to('view', @paper)].join('&nbsp;').html_safe
          else
            redirect_to @paper, notice: 'Paper was successfully created.' 
          end
        }
        format.json { render action: 'show', status: :created, location: @paper }
      else
        format.html { render action: 'new' }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    unless @paper.author.last_name == params[:paper][:author_name]
      @paper.author = Author.find_or_create_from params[:paper][:author_name]
    end

    respond_to do |format|
      if @paper.update(paper_attributes)
        format.html { redirect_to @paper, notice: 'Paper was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @paper.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @paper.destroy
    respond_to do |format|
      format.html { redirect_to papers_url }
      format.json { head :no_content }
    end
  end

  def download
    send_data @paper.document.file.download,
      type: @paper.document.file.content_type,
      filename: @paper.filename,
      disposition: 'attachment'
  end

  private
    def set_paper
      @paper = current_resource
      authorize! @paper
    end

    def current_resource
      if params[:action] == 'create'
        @current_resource ||= params[:paper] if params[:paper]
      else
        @current_resource ||= Paper.find(params[:id]) if params[:id]
      end
    end

    def paper_attributes
      params.require(:paper).permit *policy(@paper || Paper).permitted_attributes
    end

    def scope_papers
      @papers = Paper.filter(params.slice(:species, :focus, :author, :journal)).includes(:author)
      @papers = policy_scope @papers.order("#{sort_column} #{sort_direction}").order('year desc', 'authors.last_name asc').page(params[:page]).per_page(15)
    end

    def sort_column
      super(Paper.column_names + ['authors.last_name'], 'year')
    end

    def sort_direction(default = 'desc')
      super(default)
    end
end
