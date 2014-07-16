class SalesAidsController < ApplicationController
  before_action :set_sales_aid, only: [:edit, :update, :destroy, :download]

  def index
    @sales_aids = SalesAid.all.group_by(&:category)
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
      redirect_to learn_more_path, notice: 'Sales aid was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @sales_aid.update(sales_aid_attributes)
      redirect_to learn_more_path, notice: 'Sales aid was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @sales_aid.destroy
    redirect_to learn_more_url
  end

  def download
    send_data @sales_aid.document.file.download,
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