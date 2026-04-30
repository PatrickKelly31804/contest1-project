# Contest 2 - Meteor Dodge

Patrick Kelly  
CSE3120 Assembly Contest

## Overview

Meteor Dodge is a simple console survival game written in x86 assembly using MASM and the Irvine32 library.

The player controls a character at the bottom of the screen and must avoid falling meteors. The goal is to survive as long as possible and achieve the highest score.

This project was originally created for Contest 1 and improved for Contest 2 with better structure, cleanup, and documentation.

---

## Features

- Player movement (left/right)
- Falling meteors with random positions
- Collision detection
- Score tracking
- Game over screen
- Replay option
- Organized assembly procedures
- Uses Irvine32 library functions

---

## Requirements

To run this project, you must have:

- Windows OS (or Windows VM)
- MASM assembler
- Irvine32 library
- Class-provided setup (Visual Studio project or batch script)

---

## How to Run (Easy Method - Recommended)

### Using the class batch file:

1. Place `meteor_dodge.asm` in the same folder as: asm_CSE3120.bat
2. 2. Open Command Prompt in that folder
3. Run:

```bash
asm_CSE3120.bat meteor_dodge.asm


Alternative (Visual Studio)
Open the Irvine32 Visual Studio project
Replace or add meteor_dodge.asm
Make sure Irvine32 is set up correctly
Build the project
Run the program
How to Play

When the game starts:

Press any key to begin
Controls
A = move left
D = move right
R = replay after game over
Objective
Avoid the falling meteors (*)
You are the player (A) at the bottom of the screen
Survive as long as possible to increase your score
Game Rules
Meteors fall from the top of the screen
Player stays on the bottom row
If a meteor hits your position → GAME OVER
Score increases the longer you survive
You can restart after losing
Notes
This game uses Irvine32 functions such as:
WriteString, WriteChar, WriteDec
ReadChar
RandomRange, Randomize
Delay
Gotoxy, Clrscr
The game currently uses key press input, meaning:
The game updates after each key press
This keeps the implementation simple and reliable for assembly
Code is split into procedures for clarity:
RunGame
DrawGame
HandleInput
UpdateMeteors
CheckCollision
