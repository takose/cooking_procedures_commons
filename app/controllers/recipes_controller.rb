class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
    @recipe = Recipe.new
  end

  def create
    recipe = Recipe.create(recipe_params) 
    if recipe
      session[:recipe_id] = recipe.id
      recipe.steps.create!
      redirect_to new_step_path
    else
      redirect_to root_path
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def update
    session[:recipe_id] = Recipe.find(params[:id]).id
    redirect_to new_step_path
  end

  def destroy
    Recipe.find(params[:id]).destroy
    redirect_to root_path
  end

  def recipe_params
    params.require(:recipe).permit(:name)
  end
end
