class AboutController < ApplicationController
  skip_before_filter :restrict_non_visible_user, :only => [:terms]
  
  def terms
    @title = "Terms &amp; Conditions on Date Edge"
  end
end
