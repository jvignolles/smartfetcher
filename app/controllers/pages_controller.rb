class PagesController < ApplicationController
  # Accessible from `root_path` instead of  `pages_path` to avoid duplicate content.
  def index
    @pages = Page.ordered.paginate(page: params[:page])
    @page = Page.new
    @page_title = project_name
  end

  def create
    data = (params || {}).require(:page).permit(:page_id)
    page = Page.new(data)
    if page.save!
      flash[:notice] = "Page #{page.name} added"
    else
      flash[:error] = "Can't add #{page.page_id}"
    end
    return redirect_to root_path
  end

  def show
    @page = Page.find(params[:id])
    unless @page
      flash[:error] = "This page doesn't exist"
      return redirect_to root_path
    end
    @page_title = "#{@page.current_name} | #{project_name}"
    @page_heading = @page.current_name
  end
end
