class CustomSessionsController < Devise::SessionsController
  ## for rails 5+, use before_action, after_action
  after_action :after_login, :only => :create

  def after_login
    SignInLog.create(user: current_user)
  end
end
