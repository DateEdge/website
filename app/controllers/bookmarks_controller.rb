class BookmarksController < ApplicationController
  before_action :require_login
  
  def create
    bookmark = current_user.bookmarks.build(params.require(:bookmark).permit(:bookmarkee_id))
    if bookmark.save
      redirect_to back_or(person_path(bookmark.bookmarkee.username)), notice: "Added bookmark"
    else
      redirect_to back_or(root_path), notice: "There was a problem bookmarking this user"
    end
  end
  
  def destroy
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.destroy
    redirect_to back_or(root_path)
  end
end
