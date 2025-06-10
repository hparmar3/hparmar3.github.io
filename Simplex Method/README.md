# Simplex Method Solver
This project implements the <b> Simplex Method </b> for solving linear programming (LP) problems in <b> standard form </b> using MATLAB. The algorithm uses <b> Bland's Rule </b> for pivot selection and provides verbose output at each iteration to aid in understanding the solution process.

## Problem Statement
Solve the following Linear Program (LP):
```bash
minimize c'x
subject to Ax = b
x >= 0
```
Where:
- `A` is an `m x n` constraint matrix
- `b` is an `m x 1` right-hand side vector
- `c` is an `n x 1` cost vector

## Features
- Implements that <b> standard simplex algorithm </b>
- Uses <b> Bland's Rule </b> to prevent cycling
- Detects <b> unbounded </b> problems
- Step-by-step console output with:
  - Initial and updated tableau
  - Basic feasible solution at each step
  - Final optimal solution
 
## Overview
### Inputs
  ```bash
  [x_opt, z_opt] = simplex_method(A, b, c)
```
- `A` - constraint matrix (`m x n`)
- `b` - RHS vector (`m x 1`)
- `c` - cost vector (`n x 1`)

### Outputs
- `x_opt` - optimal solution vector (`n x 1`)
- `z_opt` - optimal objective value (scalar)

## Example
### Inputs
```bash
A = [1 1 1 0; 2 1 0 1];
b = [4; 6];
c = [-3; -2; 0; 0];

[x_opt, z_opt] = simplex_method(A, b, c);
```

### Outputs
```bash
Initial Tableau:
...

Iteration 1:
Updated Tableau:
...

Current Basic Feasible Solution:
...

Optimal Solution x*:
...
Optimal Objective Function Value:
...
```

## Requirements
- MATLAB
