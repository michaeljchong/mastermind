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
    temp_code = @code.clone
    guess.each_with_index do |peg, idx|
      if peg == @code[idx]
        temp_code[idx] = '='
      elsif temp_code.include?(peg)
        temp_code[temp_code.index(peg)] = '*'
      end
    end
    ['B' * temp_code.count('='), 'W' * temp_code.count('*')]
  end
end
