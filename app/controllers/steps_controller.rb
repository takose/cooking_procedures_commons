require 'Recipe2pic.rb'
class StepsController < ApplicationController
  before_action :set_val, only: [:new, :get_img]
  def new
    @word ||= ""
  end

  def get_img
    @word = params[:keyword][:keyword]
    @img_urls = get_pic(@word)
    render steps_new_path
  end

  def create
    recipe = Recipe.find(session[:recipe_id])
    recipe.steps.create()
    redirect_to new_step_path
  end

  def update
    Step.find(params[:id]).update(step_params)
    redirect_to new_step_path
  end

  def destroy
    Step.find(params[:id]).destroy
    redirect_to new_step_path
  end

  def set_val
    @recipe = Recipe.find(session[:recipe_id])
    @steps = @recipe.steps
    @step = @recipe.steps.last
    # TODO 順番をどこかにもたせる
    @element = @step.elements.new
  end

  def step_params
    # TODO stepにbodyカラム追加
    params.require(:step).permit(:note)
  end
end
