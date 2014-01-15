class SearchesController < ApplicationController
  before_action :require_login, only: [:index]
  
  def index
    @title_text = params[:column].titleize
    @groups = current_user.viewable_users.group_by_column(params[:column].to_sym)
    @total = @groups.sum(&:last)
  end
end
