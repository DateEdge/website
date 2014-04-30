class Admin::RedFlagsController < AdminController
  def index
    @red_flags = RedFlag.group(:slug).count(:id).sort_by {|slug,count| count }.reverse
  end
  
  def show
    @red_flags = RedFlag.includes(:reporter).where(slug: params[:id])
    @object    = @red_flags.take.flaggable
  end
end
