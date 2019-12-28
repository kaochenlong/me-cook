class RecipesController < ApplicationController 
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to root_path, notice: '新增成功'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to root_path, notic: '食譜已更新'
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path, notice: '資料已刪除'
  end

  private
  def recipe_params
    params.require(:recipe).permit(:title, :description, :photo)
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end
end

