<h1>Mastermind using Ruby</h1>

<p>A game of Mastermind where a player plays against the computer to see who can guess the other's code in the least number of attempts. Each party takes turns being the codemaker and the codebreaker. The number of rounds played can be set to any even number. Each round consists of up to 12 attempts for the codebreaker to guess the codemaker's code. The codemaker receives 1 point for each guess and an additional point if the codebreaker fails to guess the correct code within 12 attempts. When the computer is the codemaker, it generates a random code of 4 values. The values are selected from the following array, ['R', 'O', 'Y', 'G', 'B', 'P', ' '], representing the colors Red, Orange, Yellow, Green, Blue, Purple, along with the option of an empty value. When the computer is the codebreaker, it uses a very basic random feedback loop to find the correct code. It will choose random values until it guesses a correct character and then maintain that character. It will then continue choosing random values for the remaining characters until the next correct character is found and then maintain that character as well. This will repeat until all characters are correct.</p>

<p>Check out the final <a href='https://replit.com/@michaeljchong/mastermind?v=1'>interactive environment</a> on Replit.</p>

<h2>Lesson's Learned:</h2>
<ul>
    <li>Keep methods simple in order to allow modifying the code logic without having to rewrite larger methods</li>
    <li>Implement first and then refactor</li>
</ul>

<h2>Feature List:</h2>
<ul>
    <li>Player has the option to start as the codebreaker or codemaker</li>
    <li>Player can choose number of rounds played</li>
    <li>Custom name input</li>
    <li>Basic omputer guessing algorithm which does not factor in white pegs. It also gives a slight advantage to the computer by not having to guess which pegs have both the correct color and location.</li>
</ul>

<h2>Project Extensions:</h2>
<ul>
    <li>Implement a more rigorous computer guessing algorithm</li>
</ul>

<h2>Ruby Used:</h2>
<ul>
    <li>Classes</li>
    <li>Instance variables</li>
    <li>Constants</li>
    <li>Attribute accessors</li>
    <li>Class inheritance</li>
</ul>
