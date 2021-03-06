class SalesAidsController < ApplicationController
  before_action :set_sales_aid, only: [:show, :edit, :update, :destroy, :download]

  def index
    authorize! SalesAid
    @sales_aids = (policy_scope SalesAid.order(:category, :position)).all.group_by(&:category)
  end

  def show
    respond_with_js do
      render :nothing unless @sales_aid.video?
    end
  end

  def new
    @sales_aid = SalesAid.new
    authorize! @sales_aid
  end

  def edit
  end

  def create
    @sales_aid = current_user.sales_aids.build(sales_aid_attributes)
    authorize! @sales_aid

    if @sales_aid.save
      redirect_to manage_sales_aids_path, notice: 'Sales aid was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    respond_to do |format|
      format.html {
        if @sales_aid.update(sales_aid_attributes)
          redirect_to manage_sales_aids_path, notice: 'Sales Aid was successfully updated.'
        else
          render action: 'edit'
        end
      }
      format.json {
        new_position = params[:reposition].try(:to_i)
        if new_position && @sales_aid.insert_at(new_position)
          render json: @sales_aid, status: :created, location: @sales_aid
        else
          render json: @sales_aid.errors, status: :unprocessable_entity
        end
      }
    end
  end

  def destroy
    @sales_aid.destroy
    redirect_to manage_sales_aids_path
  end

  def manage
    @sales_aids = policy_scope(SalesAid).order(:category, :position)
    authorize! @sales_aids
  end

  def download
    send_data (open @sales_aid.document.url).read,
      type: @sales_aid.document.file.content_type,
      filename: @sales_aid.filename,
      disposition: 'attachment'
  end

  private
    def set_sales_aid
      @sales_aid = SalesAid.find(params[:id])
      authorize! @sales_aid
    end

    def sales_aid_attributes
      params.require(:sales_aid).permit *policy(@sales_aid || SalesAid).permitted_attributes
    end
end
