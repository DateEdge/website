class SearchesController < ApplicationController
  def index
    @title_text = params[:column].titleize
    
    column_name = UserRule::SQL_GROUP[params[:column].to_sym]
    @groups = current_user.viewable_users.
      includes(UserRule::ASSOCIATION_NAME[params[:column].to_sym]).
      group(column_name).
      where("#{column_name} IS NOT NULL").
      count(:id).sort_by(&:last).reverse
      
    @total = @groups.sum(&:last)
  end
end
