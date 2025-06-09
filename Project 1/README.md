# Maritime Signal Flags Visualizer

## Overview

This Java program prompts the user for input and visualizes three maritime signal flags — **Alpha**, **India**, and **Victor** — using the `StdDraw` library. Each flag is drawn with a user-defined size and delay between appearances, demonstrating the use of basic GUI drawing, user input, and control flow in Java.

## Features

- Interactive user input for:
  - Pixel size of each flag (between 100 and 400)
  - Delay (in tenths of a second) between each flag’s appearance
- Uses `StdDraw` to draw:
  - **Alpha Flag**: White and blue with a triangular cutout
  - **India Flag**: Yellow square with a black circle in the center
  - **Victor Flag**: White background with a red "X"

## Getting Started

### Prerequisites

- Java (version 8 or later)
- [StdDraw.java](https://introcs.cs.princeton.edu/java/stdlib/StdDraw.java.html) must be available in the same directory or project classpath.

### Running the Program

1. Compile the program:
   ```bash
   javac Project1.java
2. Run the program
```bash
java Project1
```
3. Follow the prompts in the terminal to enter:
  - Sizes of the Alpha, India, and Victor flags
  - Delay times between thier appearances

## Example
```sql
enter pixel size of first flag (100-400): 150  
enter pixel size of second flag (100-400): 200  
enter pixel size of third flag (100-400): 250  
enter first delay in tenths of a second: 5  
enter second delay in tenths of a second: 10  
```
This input would cause the Alpha flag (150px) to appear immediately, the India flag (200px) after a 0.5-second delay, and the Victor flag (250px) after a 1-second delay following the India flag.
