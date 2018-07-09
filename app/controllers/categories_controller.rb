class CategoriesController < ApplicationController

  def show
    @projects = Category.find(params[:id]).name
    @project =Category.find(params[:id]).projects
  end
end
