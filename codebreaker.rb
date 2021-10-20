require_relative 'player'

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
      # implement guessing algorithm
      puts "#{previous_guess}, #{previous_key}"
    end
    puts "Computer guessed #{code.join}"
    code
  end

  def human_guess
    print "#{@name}, what do you think the code is? Enter 4 letters (ex. RGBY) "
    input_code
  end
end
