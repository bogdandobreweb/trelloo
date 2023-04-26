class Boards::CreateService
  def initialize(params)
    @params = params
  end

  def call
    Board.create(@params)
  end
end