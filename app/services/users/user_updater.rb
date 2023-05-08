class Users::UserUpdater
  def initialize(user, params)
    @user = user
    @params = params
  end

  def call
    @user.update(@params)
    @user
  end
end
