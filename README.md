# contest1-project
Patrick Kelly


# Meteor Dodge (MASM + Irvine32)

Console survival game written in x86 assembly using MASM and the Irvine32 library.

## Overview
Meteor Dodge is a simple real-time console game. The player moves left and right along the bottom row while meteors fall from the top of the screen. The goal is to survive as long as possible and get the highest score possible.

## Features
- player movement with keyboard input
- falling meteors
- random meteor spawn positions
- collision detection
- score tracking
- replay option
- multiple procedures for game flow

## Requirements
- MASM toolchain
- Irvine32 library
- Windows environment for compiling/running

## Build and Run
Use the class MASM/Irvine32 setup on a Windows computer.

Example:
asm_CSE3120.bat meteor_dodge.asm

Or place `meteor_dodge.asm` into your normal Irvine Visual Studio project and build it there.

## Controls
- `a` = move left
- `d` = move right
- `r` = replay after game over

## Notes
This project uses Irvine32 procedures that were covered or referenced in class materials, including screen output, random number generation, delays, and character input. :contentReference[oaicite:4]{index=4}
If any final feature is added later that was not directly shown in class examples, it should be clearly noted in the source comments.
