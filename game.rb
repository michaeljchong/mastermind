class Board
  attr_reader :history

  def initialize
    @history = []
  end

  def display
    (0...@history.length).each do |idx|
      puts "Guess #{idx + 1}: #{@history[idx][0].join} | Key #{idx + 1}: #{@history[idx][1].join}"
    end
  end

  def add_history(guess)
    @history.push(guess)
  end

  def reset
    @history = []
  end
end

class Player
  COLOR_PEGS = [' ', 'R', 'O', 'Y', 'G', 'B', 'P'] #empty, red, orange, yellow, green, blue, purple
  attr_reader :is_computer
  attr_accessor :name, :points

  def initialize
    @name = 'Computer'
    @points = 0
    @is_computer = TRUE
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
    @is_computer = @is_computer ? FALSE : TRUE
  end
end

class Codemaker < Player
  def generate_code
    @code = @is_computer ? computer_code : human_code
  end

  def computer_code
    code = []
    4.times { code.push(COLOR_PEGS.sample) }
    code
  end

  def human_code
    print 'Enter a code (ex. RGBY): '
    input_code
  end

  def feedback(guess) # white peg count needs to be fixed
    black_pegs = 0
    white_pegs = 0
    guess.each_with_index do |peg, idx|
      if peg == @code[idx]
        puts "black: guess - #{peg} | code - #{@code[idx]}"
        black_pegs += 1
      elsif @code.include?(peg)
        puts "white: guess - #{peg} | code - #{@code[idx]}"
        white_pegs += 1
      end
    end

    print @code # for debugging, remove when finished
    key_pegs = 'B' * black_pegs + 'W' * white_pegs
    key_pegs.split('')
  end
end

class Codebreaker < Player
  def guess(board)
    @is_computer ? computer_guess(board) : human_guess
  end

  def computer_guess(board)
    code = []
    if board.history.empty?
      4.times { code.push(COLOR_PEGS.sample) }
    else
      previous_guess = board.history[-1][0]
      previous_key = board.history[-1][1]
      # guessing algorithm
    end
    puts "Computer guessed #{code.join}"
    code
  end

  def human_guess
    print "#{@name}, what do you think the code is? Enter 4 letters (ex. RGBY) "
    input_code
  end
end

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
      break if rounds.empty? || (rounds.to_f >= 2 && (rounds.to_f % 2).zero?)

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
    @codemaker.add_point
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
