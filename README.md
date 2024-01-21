# 2x2x2-RubixCubeSolver




## Description
The 2x2x2 Rubik's Cube Solver is a Prolog program that aims to solve the 2x2x2 Rubik's Cube. This solver uses Prolog's logical programming features to find a sequence of moves that will solve the cube from any given scrambled state.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
- [Technologies Used](#technologies-used)


## Prerequisites
Before you begin, ensure you have the following requirements:

- **Prolog Interpreter**: Make sure you have a Prolog interpreter installed on your system.

## Installation
Follow these steps to set up the 2x2x2 Rubik's Cube Solver:

### Step 1: Clone the Repository
```bash
git clone https://github.com/AJDevCode/rubiks-cube-solver-prolog.git
```



## Usage
 - **Solves the 2x2x2 Rubik's mini-cube using Prolog**
 - **Firstly, the program will have a "Solved State" to compare the scrambled state that the program is given** 
 - **Using the scrambled Rubix cube given, using the BFS(Breadth-first search) algorithm to solve the cube level by level until it reaches the "Solved State"**
 - **It will then extract all solutions and output the most efficient solution path possible**

## Features
 - **Solver is trackable so it can backtrack through all shortest solutions**
 - **Uses the meet-in-the-middle strategy to produce the shortest solutions possible**
   
## Technologies Used 
 - **Prolog**
 - **BFS Algorithm**
