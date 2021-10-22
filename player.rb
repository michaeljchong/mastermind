class Player
  COLOR_PEGS = [' ', 'R', 'O', 'Y', 'G', 'B', 'P'] #empty, red, orange, yellow, green, blue, purple
  attr_reader :is_computer
  attr_accessor :name, :points

  def initialize
    @name = 'Computer'
    @points = 0
    @is_computer = true
  end

  def add_point
    @points += 1
  end

  def input_code
    while (input = gets.chomp.split(''))
      break if input.length == 4 && input.all? { |value| COLOR_PEGS.include?(value) }

      print 'Invalid input. Enter 4 letters (ex. RGBY) '
    end
    input
  end

  def switch_computer_state
    @is_computer = @is_computer ? false : true
  end
end
