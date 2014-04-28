class UsersController < ApplicationController
  skip_before_filter :restrict_non_visible_user, only: [:new, :create]
  before_action      :require_login,             only: [:edit, :update, :destroy]
  before_action      :search_term,               only: :index

  def index
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
  end

  def show
    @slug  = "person"

    find_user_by_username

    if @user
      @title = "#{@user.username}&rsquo;s Profile on Date Edge"
      @crush = Crush.new

      redirect_if_age_inappropriate(@user)
    else
      redirect_to root_path, notice: "That user doesn't exist."
    end
  end

  def new
    @slug  = "settings"
    @title = "Getting Started on Date Edge"
    @user  = current_user

    if @user.nil? or @user.visible?
      return redirect_to(root_path)
    end
  end

  def create
    @user = current_user
    params[:user][:username] = User.generate_username if params[:user][:username].blank?

    if @user.update(params.require(:user).permit(:username, :email, "birthday(1i)", "birthday(2i)", "birthday(3i)", :agreed_to_terms_at))
      @user.visiblize!
      redirect_to new_photo_path(getting: "started")
    else
      render :new
    end
  end

  def edit
    @title = "Your Settings on Date Edge"
    @slug  = "settings"
    @user  = current_user
    @label_assignements = @user.your_labels.label_assignments
  end

  def update
    @user = current_user

    if current_user.update(user_params)
      redirect_to(person_path(current_user.username), notice: "Your settings were successfully updated.")
    else
      @label_assignements = @user.your_labels.label_assignments
      render action: "edit"
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    cookies.delete :auth_token
    redirect_to root_path, notice: "Profile deleted. We'll miss you. Come on back any time."
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

    if User::DISALLOWED_COLUMNS.include? @column.try(:to_sym)
      @search, @column = [@query, nil]
      params[:search] = @search
    end
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :website,
      :birthday_public,
      :real_name_public,
      :email_public,
      "birthday(1i)",
      "birthday(2i)",
      "birthday(3i)",
      :city,
      :state_id,
      :zipcode,
      :country_id,
      :bio,
      :diet_id,

      :facebook_username,
      :instagram_username,
      :kik_username,
      :lastfm_username,
      :snapchat_username,
      :spotify_username,
      :thisismyjam_username,
      :tumblr_username,
      :twitter_username,
      :vine_username,

      :me_gender,
      :you_gender,
      :label_id,
      your_labels_attributes: [:label_id, :id, :_destroy, :label_type]
    )
  end
end
