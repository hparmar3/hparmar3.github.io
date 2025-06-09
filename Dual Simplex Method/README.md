# Dual Simplex Method for Linear Programming (MATLAB)
This repository contains a MATLAB implementation of the <b> Dual Simplex Method </b>, a power optimization algorithm used to solve linear programming problems when the initial solution is dual feasible but not necessarily primal feasible.

## Problem Formulation
This function solves the linear program:
```bash
minimize     cᵗx  
subject to   Ax = b  
             x ≥ 0
```
Using the <b> Dual Simplex Method, </b> particularly useful when the right-hand side (`b`) contains negative values, making the initial solution infeasible.

## Function: `dual_simplex.m`
### Syntax
```bash
[x_opt, z_opt, y_opt] = dual_simplex(A, b, c)
```
### Inputs
- `A` - Constraint matrix (size `m x n`)
- `b` - Right-hand side vector (size `m x 1`)
- `c` - Cost vector for the objective function (size `n x 1`)

### Outputs
- `x_opt` - Optimal solution vector for the primal problem (`n x 1`)
- `z_opt` - Optimal objective function value (scalar)
- `y_opt` - Optimal solution vector for the <b> dual </b> problem (`m x 1`)

## Algorithm Highlights
- Converts problem to <b> standard form </b> by introducing slack variables
- Constucts an initial tableau with slack variables and objective row
- 
