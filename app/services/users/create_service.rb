class Users::CreateService
    def initialize(params)
      @params = params
    end
  
    def call
      User.create(@params)
    end
  end