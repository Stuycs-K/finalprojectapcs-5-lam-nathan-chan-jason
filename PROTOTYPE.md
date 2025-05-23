
# Technical Details:

PERIOD 5
Nathan Lam, Jason Chan
Group Name: The Overcomplicated Coders

We will be making a processing version of tetris, but with the added features of irregularly shaped blocks such as:

OOO        OO
O O  and OOO
OOO

This will also include the added ability to clear specific 3x3 squares instead of rows.  We plan to extend the column count from tetris' 10 to 12 to fit a multiple of 3 to make this convenient.
all other features will be directly the same as normal tetris: line clears, acceleration, score, color changes with levels, etc.

Minimum Viable Product:
a normal tetris game with 12 columns instead of 10, and more block types
Desired features: 3x3 clears, combo counter.

# Project Design

UML Diagrams and descriptions of key algorithms, classes, and how things fit together.

There will be a block class that will contain information about each block as well as the functions to move and rotate the block. The most important functions are the fall function (moves the block down by one unit), the left/right functions (checks if the block can move left/right, if so, shifts the block one unit left/right), and the rotate functions (rotate the block following the Super Rotation System guidelines).

The main/game class will constantly call the fall function one tick at a time and the left/right and rotate functions can be called by certain keybinds. When the block is placed down (where the block does not have room to move down), then the checkRow function will scan the entire board to see if the blocks have filled up an entire row. If so, then the clearRow function clears the filled up rows and adds to the current score and combo, depending on what the type of clear is (single, double, tetris, etc).

![Alt text](uml.jpg?raw=true "Adding by Index Diagrams" )

# Intended pacing:

How you are breaking down the project and who is responsible for which parts.

A timeline with expected completion dates of parts of the project. (CHANGE THIS!!!!!)
5/21: Finish the Prototype. (Jason/Nathan)
5/25: Finish the Block class along with a small main to test the mechanics to the game. (Jason)
5/28: Complete the main class so that the game functions. (Nathan)
5/31: Finish any QOL features like scoring, combo, etc. (Nathan/Jason)
Due Date: Finish any extra features like T-spins, back to back tetrises, etc. (Nathan/Jason)
