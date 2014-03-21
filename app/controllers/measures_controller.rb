class MeasuresController < ApplicationController
  before_action :set_trial, only: :new
  before_action :set_measure, only: [:edit, :update, :destroy]

  def new
    @measure = @trial.performance_measures.build
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js { render action: 'new' }
    end
  end

  def create
    @measure = PerformanceMeasure.new measure_attributes

    respond_to do |format|
      if @measure.save
        format.js
      else
        format.js { render 'error' }
      end
    end
  end

  def update
    respond_to do |format|
      if @measure.update(measure_attributes)
        format.js
      else
        format.js { render 'error' }
      end
    end
  end

  def destroy
    @measure.destroy
    respond_to do |format|
      format.js
    end
  end

  private
    def set_trial
      @trial = Trial.find(params[:trial]) if params[:trial]  
    end

    def set_measure
      @measure = current_resource
      authorize! @measure
    end

    def current_resource
      if params[:action] == 'create'
        @current_resource ||= params[:performance_measure] if params[:performance_measure]
      else
        @current_resource ||= PerformanceMeasure.find(params[:id]) if params[:id]
      end
    end

    def measure_attributes
      params.require(:performance_measure).permit *policy(@measure || PerformanceMeasure).permitted_attributes
    end

end
