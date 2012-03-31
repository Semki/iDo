class UserController < ActionController::Base
  def register
    
  end

  def new_user
    username = params[:username]
    password = params[:password]
    password_confirmation = params[:password_confirmation]

    @result = {}

    # Проверки
    @result[:result] = (password_confirmation == password)

    # Здесь нужно сохранить его в базу
  end

  def login
    # todo
  end
end
