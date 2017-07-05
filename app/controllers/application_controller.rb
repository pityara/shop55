class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize

  protected
    def authorize
      unless session[:user_id]
        redirect_to login_url, notice: "Авторизируйтесь!"
      end
    end
end
