class PagesController < ApplicationController
  def about
  end

  def welcome
    render layout: 'welcome'
  end
end
