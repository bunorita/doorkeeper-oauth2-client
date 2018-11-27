class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def doorkeeper # メソッド名はstrategyで指定した名前
    @user = User.find_or_create_with_doorkeeper(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in(@user)
      set_flash_message(:notice, :success, kind: 'doorkeeper') if is_navigational_format?
      redirect_to '/'
    else
      session['devise.doorkeeper_data'] = request.env['omniauth.auth']
      redirect_to '/', alert: 'Doorkeeper ログインに失敗しました'
    end
  end
end
