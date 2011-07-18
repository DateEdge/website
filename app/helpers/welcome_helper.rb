module WelcomeHelper
  def welcome?
    controller_name == "welcome" && action_name == "index"
  end
end
