# Conway's Game of Life

## Operation Instructions

### After Uploading the Design from ModelSim to the FPGA:
**Note:** Connect the 16x16 LED array to the FPGA to observe the game.

#### Selecting Rows and Columns:
- **SW[3:0]:** Selects the number of rows.
- **SW[7:4]:** Selects the number of columns.
- **Important:** A basic understanding of binary is required to efficiently navigate the 16x16 LED array.

### Example:
- **To select row 4:** Set SW[3:0] to `0100`, which is `4` in binary.
- **To select column 5:** Set SW[7:4] to `0101`, which is `5` in binary.

## Inputting into the LED Array:
- Once you have selected the desired row and column, flip **switch 8** up to input the selection into the LED array.
- **Note:** The LED array indexing starts from 0.

## Activating Another Cell (LED):
1. Flip any other switch down.
2. Flip **switch 8** down.
3. Repeat the process described above to select a different row and column for activating another cell in the array.

## Running the Game:
- After setting up your pattern, flip **switch 9** up to start the simulation.
- Observe the LED array as it follows the rules of Conway's Game of Life.

## Game of life rules: 

Conway's Game of Life is played on an infinite grid of square cells, each of which is either live or dead. The game is governed by two simple rules:

- **Rule 1:** A dead cell with exactly three neighbors comes to life.
- **Rule 2:** A living cell with less than two or more than three neighbors dies.

Once you've set up the initial arrangement of cells, the two rules are applied to create the next generation, and then the one after that, and so on. The process is completely automatic, which is why Conway called it a "zero-player game."

Even though the rules are simple, the game can generate a wide variety of behavior:

- **Stable Patterns:** Some patterns, once they arise, never change.
- **Oscillators:** Other patterns oscillate back and forth in a loop.
- **Spaceships:** A few patterns, like the glider, can travel across the grid indefinitely.

These characteristics make Conway's Game of Life both fascinating and fun, despite being a zero-player game.
