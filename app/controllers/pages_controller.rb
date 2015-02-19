class PagesController < ApplicationController
  # Accessible from `root_path` instead of  `pages_path` to avoid duplicate content.
  def index
    init_listing
  end

  def create
    data = (params || {}).require(:page).permit(:page_id)
    @page = Page.new(data)
    unless @page.save
      init_listing
      return render "index"
    end
    flash[:notice] = "Page « #{@page.name} » added"
    redirect_to root_path
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

private
  def init_listing
    @pages = Page.ordered.paginate(page: params[:p])
    @page ||= Page.new
    @page_title = project_name
  end
end
