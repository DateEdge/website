class SearchesController < ApplicationController
  def index
    @groups = User.
      preload(UserRule::ASSOCIATION_NAME[params[:column].to_sym]).
      select(UserRule::SELECT[params[:column].to_sym]).
      group_by(&:"#{UserRule::COLUMN[params[:column].to_sym].to_s}")
  end
end
