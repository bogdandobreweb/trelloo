class Users::UserCreator
include CommonHelper

    def initialize(params)
      @params = params
      @errors = []
      @successes = []
    end
  
    def call
      User.create(@params)
      
    end
end