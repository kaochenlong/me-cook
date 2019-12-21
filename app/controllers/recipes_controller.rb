class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    begin
      @recipe = Recipe.find(params[:id])
    rescue
      render file: 'public/404.html'
    end
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

  def edit
    begin
      @recipe = Recipe.find(params[:id])
    rescue
      render file: 'public/404.html'
    end
  end

  def update
    clean_params = params.require(:recipe).permit(:title, :description)

    begin
      @recipe = Recipe.find(params[:id])

      if @recipe.update(clean_params)
        redirect_to root_path
      else
        render :edit
      end

    rescue
      render file: 'public/404.html'
    end
  end

  def destroy
    begin
      @recipe = Recipe.find(params[:id])
      @recipe.destroy
      redirect_to root_path
    rescue
      render file: 'public/404.html'
    end
  end
end

