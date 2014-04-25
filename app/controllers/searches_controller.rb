class SearchesController < ApplicationController
  before_action :require_login, only: [:index]
  before_action :search_term, only: :show

  def index
    @title_text = params[:column].titleize
    @groups     = current_user.viewable_users.group_by_column(params[:column].to_sym)
    @total      = @groups.sum(&:last)
  end

  def show
    @title       = "People Using Date Edge"
    @slug        = "people"
    @avatar_size = :square

    @users = if logged_in?
      current_user.viewable_users.search(@search)
    else
      User.visible
    end

    @total = @users.count
    @users = @users.order('created_at desc').paginate(page: params[:page] ||= 1)

    render "/users/index"
  end

  private

  def search_term
    return unless params[:search]

    search = params[:search].split("/", 2)
    @search, @query, @column = if search.count.even?
      [Hash[*search], search.last, search.first]
    else
      [search.first, search.first, nil]
    end

    @column = nil unless User::ALLOWED_SEARCH_COLUMNS.include? @column
  end
end
