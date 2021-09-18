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
  attr_accessor :name, :points

  def initialize
    @name = ''
    @points = 0
  end

  def add_point
    @points += 1
  end
end

class Codemaker < Player
  def initialize
    super
    @code = []
  end

  def generate_code
    @code = []
    4.times { @code.push(COLOR_PEGS.sample) }
  end

  def feedback(guess)
    black_pegs = 0
    white_pegs = 0
    @code.each_with_index do |peg, idx|
      if peg == guess[idx]
        black_pegs += 1
      elsif @code.include?(guess[idx])
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
    while (guess = gets.chomp.split(''))
      break if guess.length == 4 && guess.all? { |value| COLOR_PEGS.include?(value) }

      print 'Invalid input. Enter 4 letters (ex. RGBY) '
    end
    guess
  end
end

class Game
  def initialize
    @board = Board.new
    @codemaker = Codemaker.new
    @codebreaker = Codebreaker.new
    @num_rounds = 2 #must be an even number
  end

  def intro
    puts "Let's play a game of Mastermind!"
    puts 'The available code options are red, orange, yellow, green, blue, purple. The code can also be empty.'
    puts 'The code is 4 characters in length.'
    puts "When guessing, enter the capitalized first letter of the color or a 'space'."
    puts 'For example, a guess of red, green, empty, blue would look like => RG B'
    puts "Let's begin..."
  end

  def set_names
    print 'Who is playing? (default: Human) '
    name = gets.chomp
    @codebreaker.name = name.empty? ? 'Human' : name
    @codemaker.name = 'Computer'
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

  def show_score
    puts "#{@codemaker.name} - #{@codemaker.points} points."
    puts "#{@codebreaker.name} - #{@codebreaker.points} points."
  end

  def switch_roles
    temp_name = @codemaker.name
    temp_points = @codemaker.points
    @codemaker.name = @codebreaker.name
    @codemaker.points = @codebreaker.points
    @codebreaker.name = temp_name
    @codebreaker.points = temp_points
  end

  def result
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
    intro
    set_names
    @num_rounds.times do
      show_score
      play_round
      switch_roles
      @board.reset
    end
    result
  end
end

Game.new.play
