class Users::ViewService
    def initialize(user)
      @user = user
    end
  
    def call
      @user
    end
  end