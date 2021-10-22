require_relative 'player'

class Codebreaker < Player
  def guess(board, code)
    @is_computer ? computer_guess(board, code) : human_guess
  end

  def computer_guess(board, code)
    current_guess = []
    if board.history.empty?
      4.times { current_guess << COLOR_PEGS.sample }
    else
      previous_guess = board.history[-1][0]
      code.each_with_index do |peg, idx|
        current_guess.push peg == previous_guess[idx] ? peg : COLOR_PEGS.sample
      end
    end
    puts "Computer guessed #{current_guess.join}"
    current_guess
  end

  def human_guess
    print "#{@name}, what do you think the code is? Enter 4 letters (ex. RGBY) "
    input_code
  end
end
