class GendersController < ApplicationController
  def index
    genders  = User.all.map{|u| u.me_gender}
    @genders = Hash.new

    genders.each do |gender|
      @genders[gender] = User.where(me_gender: gender).count
    end

    @genders = @genders.sort_by{ |gender| gender.last }.reverse
  end

  def show
    @gender = params[:gender]
    @users  = User.where(me_gender: @gender).paginate(page: params[:page] ||= 1)
    @total  = User.where(me_gender: @gender).count
  end
end
