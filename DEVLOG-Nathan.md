# Dev Log:

This document must be updated daily every time you finish a work session.

## Nathan Lam CHANGE THE NAME FOOL!

### 2025-05-27 - planning + basic func
spent ~30 mins working out logic for rotation and how we should store tetrominoes, added basic set and get methods for the board array, will implement tetromino falling, rotation, and placement on the map tomorrow/at home today.

### 2025-05-28 - shape 3d arrays
spent class time inputting explicitly declared shape arrays into a 3d array with the 4 rotation states.  added those 3d arrays to a hash table for easy expansion.

### 2025-05-29 - shape display testing
finished putting in all of the 3d arrays, tested display for tetrominoes
at home resized the board and made the left-right shift function.


### 2025-05-30 - rotation offset - wallkicks
added in tetromino rotation offset values according to tetris SRS system, implemented wallkicks.

### 2025-06-01 - fall - new tetromino - game progression
fixed some issues with clearRows, made the tetrominoes fall over time, made the game actually run.

### 2025-06-02 - colors
added all the colors of the blocks, and changed the tetromino sprite to look a bit different.

### 2025-06-03 - new colors
changed the color system to HSB to improve the visuals.

### 2025-06-04 - bucket
changed random gen of blocks from completely random to the bucket system in actual tetris.

### 2025-06-06 - ghost
made the little ghost icon that shows where the hard drop will put the blocks

### 2025-06-08 - final touches
fixed the adding of new blocks, big O, big L, little diagonal.  added softdrop.
added speed scaling and reworked levels
