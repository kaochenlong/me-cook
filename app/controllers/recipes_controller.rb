class RecipesController < ApplicationController 
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_recipe, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def my
    @recipes = current_user.recipes
    render :index
  end

  def new
    @recipe = Recipe.new
  end

  def create
    # @recipe = Recipe.new(recipe_params)
    # @recipe.user = current_user

    @recipe = current_user.recipes.new(recipe_params)

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
    params.require(:recipe).permit(:title, :description, :photo, :price)
  end

  def find_recipe
    @recipe = current_user.recipes.find(params[:id])
  end
end

