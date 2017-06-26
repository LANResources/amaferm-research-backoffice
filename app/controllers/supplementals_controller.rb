class SupplementalsController < ApplicationController
  before_action :set_paper
  before_action :scope_supplementals, only: [:index]
  before_action :set_supplemental, only: [:edit, :update, :destroy, :download]
  before_action :set_source, except: [:index, :download]

  def index
  end

  def new
    @supplemental = @paper ? @paper.supplementals.build : Supplemental.new
  end

  def create
    @author = Author.find_or_create_from params[:supplemental][:author_name]
    @supplemental = @author.supplementals.build supplemental_attributes

    if @supplemental.save
      if params[:commit] == 'Create and Add Another'
        redirect_to source_form, notice: [
                                    'Supplemental was successfully created.',
                                    view_context.link_to('View', @supplemental.paper)
                                  ].join('&nbsp;').html_safe
      else
        redirect_to @source, notice: 'Supplemental was successfully created.'
      end
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    unless @supplemental.author.last_name == params[:supplemental][:author_name]
      @supplemental.author = Author.find_or_create_from params[:supplemental][:author_name]
    end

    if @supplemental.update(supplemental_attributes)
      redirect_to @source, notice: 'Supplemental was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @supplemental.destroy
    redirect_to @source, notice: 'Supplemental was successfully removed.'
  end

  def download
    send_data (open @supplemental.document.url).read,
      type: @supplemental.document.file.content_type,
      filename: @supplemental.filename,
      disposition: 'attachment'
  end

  private

  def set_paper
    @paper = Paper.find params[:paper_id] if params[:paper_id]
  end

  def set_supplemental
    @supplemental = current_resource
    authorize! @supplemental
  end

  def current_resource
    if params[:action] == 'create'
      @current_resource ||= params[:supplemental] if params[:supplemental]
    else
      @current_resource ||= Supplemental.find(params[:id]) if params[:id]
    end
  end

  def supplemental_attributes
    params.require(:supplemental).permit *policy(@supplemental || Supplemental).permitted_attributes
  end

  def scope_supplementals
    @supplementals = Supplemental.with_paper_and_author.uniq
    @supplementals = policy_scope @supplementals.order("#{sort_column} #{sort_direction}").order('paper_id asc, source_sub_id asc')
    @supplementals = @supplementals.page(params[:page]).per_page(15)
  end

  def sort_column
    super(Supplemental.column_names, 'paper_id')
  end

  def set_source
    if params[:source]
      @source = params[:source]
    elsif params[:paper_id]
      @source = url_for(@supplemental ? @supplemental.paper : @paper)
    else
      @source = supplementals_url
    end
  end

  def source_form
    @source == supplementals_url ? new_supplemental_path : new_paper_supplemental_path(@supplemental.paper)
  end
end
