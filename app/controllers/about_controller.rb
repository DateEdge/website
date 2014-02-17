class AboutController < ApplicationController
  skip_before_filter :restrict_non_visible_user, only: [:terms, :privacy]

  def terms
    @slug  = "about"
    @title = "Terms &amp; Conditions on Date Edge"
  end
  
  def privacy
    @slug = "privacy"
    @title = "Privacy Policy on Date Edge"
  end

  def us
    @slug  = "about"
    @title = "About Us, The Site and Code of Conduct"
  end
  
  def goodbye
    @slug  = "about"
    @title = "Goodbye, old friend! Come back anytime."
  end
end
