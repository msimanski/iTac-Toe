The following file contains a description of all ten required concepts needed for the project. It will be uploaded with the final zipped project folder, and it will also be in the main project directory.

The code itself is heavily annotated, so whats below does not tell the whole story.

Xcode does not have spellcheck, so this is probably filled with errors.

Concept 1, Topic 10, alerts:
I used several aletrs to signal the player if they won, lost, or came to a draw in their game.

Concept 2, Topic 17, shaking:
I used a shaking event handler to implement an easter egg that changes the color of the button.

Concept 3, Topic 3, arrays:
Several arrays are used in my code to document the state of the game board, as well as store simulated game outcomes.

Concept 4, struct:
I made a custom struct gameMove to represent a move made in the game. It made the code much easier to work with, and to read.

Concept 5, func:
I used many custom functions in my program. It would be impossible, or very difficult to program this without them.

Concept 6, miniMax:
The main algorith that powers the AI is called miniMax. It has been around since the 40s, and it works very well solving determinate games like Tic-Tac-Toe. It works by recusively generating a tree of all possible game states, based on what is currently on the board. It then scores each of the states and finds out which branch of the tree would be most beneficial to take. The miniMax function cannot do anything on it's own without a driver function to implement it.

Concept 7, recursion:
As mentioned above, the miniMax algorithm is recurisive, meaning the function is written as to call itself. Recursion is very useful for solving complex problems with very few lines of code needed.

Concept 8, random number generation:
I cannot recall if random number generation was ever mentioned in class. Regardless, I used a random number generatior to randomly place a computer "O" somewhere on the board to start the game. This is done when the app starts, as well as when resetGame() is called.

Concept 9, for loop "cheating":
Swift allows you to declare for loops and set the bounds of the counter using "..." notation. So you could make a loop with counter i that iterates i from 0...9. I like this feature as it saves me headache, so I used it in all of my loops for this project.

Concept 10, location:
I made an easter egg based on the physical location of where the app is being run. In the UK they call Tic-Tac-Toe "Nots-N-Crosses" because thery are smug bastards and love to call things by the wrong name. If you run the app within 100 miles of London, or simulate the app location to be London, the title with change to "iNots-N-Crosses".
