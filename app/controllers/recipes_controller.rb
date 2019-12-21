class RecipesController < ApplicationController

  def index
  end

  def new
    @recipe = Recipe.new
  end

  def create
    # Strong Parameter
    clean_params = params.require(:recipe).permit(:title, :description)
    @recipe = Recipe.new(clean_params)

    if @recipe.save
      redirect_to "/"
    else
      render :new   # app/views/recipes/new.html.erb
    end
  end
end

