require_relative 'board'
require_relative 'codemaker'
require_relative 'codebreaker'

class Game
  def initialize
    @board = Board.new
    @codemaker = Codemaker.new
    @codebreaker = Codebreaker.new
    @num_rounds = 2
  end

  def display_intro
    puts "Let's play a game of Mastermind!"
    puts 'The available code options are red, orange, yellow, green, blue, purple. The code can also be empty.'
    puts 'The code is 4 characters in length.'
    puts "When inputting a code, enter the capitalized first letter of the color or a 'space'."
    puts 'For example, a code of red, green, empty, blue would look like => RG B'
    puts "Let's begin..."
  end

  def choose_role
    puts 'Whould you like to start as the codebreaker or the codemaker?'
    print 'Enter 1 for codebreaker; 2 for codemaker (default: 1) '
    while (role = gets.chomp)
      break if role.empty? || (role.length == 1 && ['1', '2'].include?(role))

      print 'Invalid input. Enter 1 for codebreaker; 2 for codemaker (default: 1) '
    end
    role == '2' ? @codemaker.switch_computer_state : @codebreaker.switch_computer_state
  end

  def set_names
    print 'Who is playing? (default: Human) '
    name = gets.chomp
    if @codebreaker.is_computer
      @codemaker.name = name.empty? ? 'Human' : name
    else
      @codebreaker.name = name.empty? ? 'Human' : name
    end
  end

  def set_num_rounds
    print 'How many rounds would you like to play? (must be a positive, even integer to allow for fair gameplay)(default: 2) '
    while (rounds = gets.chomp)
      return if rounds.empty?
      break if rounds.to_f >= 2 && (rounds.to_f % 2).zero?

      print 'Invalid input. Enter a positive, even integer (default: 2) '
    end
    @num_rounds = rounds.to_i
  end

  def play_round
    @codemaker.generate_code
    12.times do
      guess = @codebreaker.guess(@board)
      key_pegs = @codemaker.feedback(guess)
      @board.add_history([guess, key_pegs])
      @board.display
      return if key_pegs == ['B', 'B', 'B', 'B']

      @codemaker.add_point
    end
    puts "The code was #{@codemaker.code}"
  end

  def display_score
    puts "#{@codemaker.name} - #{@codemaker.points} points."
    puts "#{@codebreaker.name} - #{@codebreaker.points} points."
  end

  def switch_roles
    @codemaker.name, @codebreaker.name = @codebreaker.name, @codemaker.name
    @codemaker.points, @codebreaker.points = @codebreaker.points, @codemaker.points
    @codemaker.switch_computer_state
    @codebreaker.switch_computer_state
  end

  def reset_board
    @board.reset
  end

  def display_result
    puts "#{@codemaker.name} has #{@codemaker.points} points."
    puts "#{@codebreaker.name} has #{@codebreaker.points} points."
    if @codemaker.points > @codebreaker.points
      puts "#{@codemaker.name} won!"
    elsif @codebreaker.points > @codemaker.points
      puts "#{@codebreaker.name} won!"
    else
      puts "It's a draw!"
    end
  end

  def play
    display_intro
    choose_role
    set_names
    set_num_rounds
    @num_rounds.times do
      display_score
      play_round
      switch_roles
      reset_board
    end
    display_result
  end
end

Game.new.play
