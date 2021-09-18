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
  def initialize(name)
    @name = name
    @points = 0
  end
end

class Codemaker < Player
  def initialize
    super
    @code = []
  end

  def generate_code
    # @code = random pattern of 4 code pegs
  end

  def feedback(codebreaker_guess)
    # black keypegs for correct color and location
    # white keypegs for correct color but not location
  end
end

class Codebreaker < Player
  def guess
#     input guess and check for valid input

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
