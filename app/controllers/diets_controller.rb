class DietsController < ApplicationController
  def index
    diets = Diet.all

    @diets = {}

    diets.each do |diet|
      @diets[diet.name] = User.where(diet: diet).count
    end

    @diets = @diets.sort_by{ |diet| diet.last }.reverse
  end

  def show
  end
end
