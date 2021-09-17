=begin
Board
  initialize
    guess_history
    feedback_history
  display
    show history of guesses and feedback

Player
  initialize
    name
    points

Codebreaker < Player
  guess
    input guess and check for valid input

Codemaker < Player
  initialize
    code
  generate_code
    code = random pattern of 4 code pegs
  feedback(codebreaker_guess)
    black keypegs for correct color and location
    white keypegs for correct color but not location

Game
  initialize
    Board
    Codemaker
    codebreaker
    number of rounds
    score
  play_round
    codemaker.generate_code
    loop 12 times until correct guess
      guess = codebreaker.guess
      codemaker.feedback(guess)
      return if feedback is 4 black keypegs
      increase codemaker score by 1
    increase codemaker score by 1
  play
    loop number of rounds
      play_round
    declare winner
