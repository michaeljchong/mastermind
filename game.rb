class Board
  def initialize
    @guess_history = []
    @feedback_history = []
  end

  def display
    (0...@guess_history.length).each do |idx|
      puts "Guess #{idx}: #{@guess_history[idx].join} | Key #{idx}: #{@feedback_history[idx].join}"
    end
  end

  def add_guess(guess)
    @guess_history.push(guess)
  end

  def add_feedback(feedback)
    @feedback_history.push(feedback)
  end

  def reset
    @guess_history = []
    @feedback_history = []
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

  def feedback(guess)
    black_pegs = 0
    white_pegs = 0
    guess.each_with_index do |peg, idx|
      if peg == @code[idx]
        black_pegs += 1
      elsif guess.include?(@code[idx])
        white_pegs += 1
      end
    end
    print @code
    key_pegs = 'B' * black_pegs + 'W' * white_pegs
    key_pegs.split('')
  end
end

class Codebreaker < Player
  def guess
    print "#{@name}, what do you think the code is? Enter 4 letters (ex. RGBY) "
    @is_computer ? computer_guess : human_guess
  end

  def computer_guess
    ['R', 'R', 'R', 'R']
  end

  def human_guess
    input_code
  end
end

class Game
  NUM_ROUNDS = 2 # must be an even number

  def initialize
    @board = Board.new
    @codemaker = Codemaker.new
    @codebreaker = Codebreaker.new
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
    role == 2 ? @codebreaker.switch_computer_state : @codemaker.switch_computer_state
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

  def play_round
    @codemaker.generate_code
    12.times do
      guess = @codebreaker.guess
      @board.add_guess(guess)
      key_pegs = @codemaker.feedback(guess)
      @board.add_feedback(key_pegs)
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
    NUM_ROUNDS.times do
      display_score
      play_round
      switch_roles
      reset_board
    end
    display_result
  end
end

Game.new.play
