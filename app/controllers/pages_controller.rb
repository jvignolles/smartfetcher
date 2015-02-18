class PagesController < ApplicationController
  def index
    @pages = Page.all
  end

  def show
    @pages = Page.find(params[:id])
    #TODO
  end
end
