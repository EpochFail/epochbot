class BaseController < Rubot::Controller
  # Returns the user that sent the current message. This object
  # will be cached per instance (i.e. very short life cycle).
  def current_user
    @current_user ||= User.from_nick message.from
  end
end