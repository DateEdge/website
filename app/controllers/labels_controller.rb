class LabelsController < ApplicationController
  def index
    labels  = Label.all
    @labels = {}

    labels.each do |label|
      @labels[label.name] = User.where(label: label).count
    end

    @labels = @labels.sort_by{ |label| label.last }.reverse
  end

  def show
    @label  = Label.where(name: params[:label]).first
    @users = User.where(label: @label).paginate(page: params[:page] ||= 1)
    @total = User.where(label: @label).count
  end
end
