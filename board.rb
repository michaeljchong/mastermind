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
