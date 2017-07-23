class SessionsController < ApplicationController
  skip_before_action :authorize;

  def new

  end

  def create
    p params[:user_id]
    user = User.find(params[:user][:id])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Доброго времени суток, #{current_user.name}"
    else
      redirect_to login_url, notice: "Неверная комбинация имени и пароля"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Сеанс работы завершен"
  end
end
