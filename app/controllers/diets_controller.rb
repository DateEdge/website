class DietsController < ApplicationController
  def index
    diets  = Diet.all
    @diets = {}

    diets.each do |diet|
      @diets[diet.name] = User.where(diet: diet).count
    end

    @diets = @diets.sort_by{ |diet| diet.last }.reverse
  end

  def show
    @diet  = Diet.where(name: params[:diet]).first
    @users = User.where(diet: @diet).paginate(page: params[:page] ||= 1)
    @total = User.where(diet: @diet).count
  end
end
