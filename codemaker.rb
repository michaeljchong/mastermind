require_relative 'player'

class Codemaker < Player
  attr_reader :code

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
      elsif @code.include?(peg) # needs to be fixed
        white_pegs += 1
      end
    end

    print @code # used for debugging
    key_pegs = 'B' * black_pegs + 'W' * white_pegs
    key_pegs.split('')
  end
end
