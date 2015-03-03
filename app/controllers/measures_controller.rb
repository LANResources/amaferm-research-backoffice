class MeasuresController < ApplicationController
  before_action :set_trial, only: :new
  before_action :set_measure, only: [:edit, :update, :destroy]

  def new
    @measure = @trial.performance_measures.build
    respond_with_js
  end

  def edit
    respond_with_js { render action: 'new' }
  end

  def create
    @measure = PerformanceMeasure.new measure_attributes

    respond_with_js do
      render 'error' unless @measure.save
    end
  end

  def update
    respond_with_js do
      render 'error' unless @measure.update(measure_attributes)
    end
  end

  def destroy
    @measure.destroy
    respond_with_js
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
