class Board
  def initialize
    @guess_history = [['R','G','B','Y'], ['R','G','B','Y']]
    @feedback_history = [['W','W','B','B'], ['B','W','B','B']]
  end

  def display
    (0...@guess_history.length).each do |idx|
      puts "Guess #{idx}: #{@guess_history[idx]} | Key #{idx}: #{@feedback_history[idx]}"
    end
  end

  def add_guess(guess)
    @guess_history.push(guess)
  end

  def add_feedback(feedback)
    @feedback_history.push(feedback)
  end
end

class Player
  COLOR_PEGS = [' ', 'R', 'O', 'Y', 'G', 'B', 'P'] #empty, red, orange, yellow, green, blue, purple
  def initialize(name)
    @name = name
    @points = 0
  end
end

class Codemaker < Player
  def initialize(name)
    super(name)
    @code = []
  end

  def generate_code
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
    key_pegs = 'B' * black_pegs + 'W' * white_pegs
    key_pegs.split('')
  end
end

class Codebreaker < Player
  def guess
    print 'What do you think the code is? Enter 4 letters (ex. RGBY) '
    while (guess = gets.chomp.split(''))
      break if guess.length == 4 && guess.all? { |value| COLOR_PEGS.include?(value) }

      print 'Invalid input. Enter 4 letters (ex. RGBY)'
    end
    guess
  end
end

# Game
#   initialize
#     Board
#     Codemaker
#     codebreaker
#     number of rounds
#     score
#   play_round
#     codemaker.generate_code
#     loop 12 times until correct guess
#       guess = codebreaker.guess
#       codemaker.feedback(guess)
#       return if feedback is 4 black keypegs
#       increase codemaker score by 1
#     increase codemaker score by 1
#   play
#     loop number of rounds
#       play_round
#       switch player roles
#     declare winner

Board.new.display
maker = Codemaker.new("Bob")
maker.generate_code
p maker
p maker.feedback(["R", "R", "G", "B"])
breaker = Codebreaker.new("Joe")
breaker.guess
