class ApplicationController < ActionController::API
  include ActionController::Cookies
  include AbstractController::Helpers
  helper_method :current_user

  before_action :check_custom_header
  before_action :require_login

  private

  def check_custom_header
    # カスタムヘッダがなければ不正なリクエストと判定
    return if request.headers[:HTTP_MY_HEADER] == "My-Header-Content"
    render status: 400, json: { message: 'Invalid Request' }
  end

  def require_login
    render status: 401, json: { message: 'ログインしてください。' } unless logged_in?
  end

  def logged_in?
    !!current_user
  end

  def current_user
    unless defined?(@current_user)
      @current_user = User.find_by(id: session[:user_id])
    end
    @current_user
  end
end
