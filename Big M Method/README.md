# Big M Method for Linear Programming (MATLAB)
This repository containss a MATLAB implementation of the <b> Big M Method, </b> a technique for solving linear programming problems involving equality constraints and artifical variables.

## Overview
The <b> Big M Method </b> is an extension of the simplex method used to solve linear programming problems of the form:
```bash
minimize     cᵗx  
subject to   Ax = b  
             x ≥ 0
```
When the initial basic feasible solution is not readily avaliable, artifical variables and a large penalty term <b> M </b> are introduced to drive the solution toward feasibility while maintaining optimality.

## Function `big_M_method.m`
### Syntax
```bash
[x_opt, z_opt] = big_M_method(A, b, c)
```
### Inputs
- `A` - Coefficient matrix for constraints (size `m x n`)
- `b` - Right-hand side vector (`m x 1`)
- `c` - Cost vector (`n x 1`)

### Outputs
- `x_opt` - Optimal decision variable vector (`n x 1`)
- `z_opt` - Optimal objective function value (scalar)

### Features
- Handles equality constraints using artifical variables
- Automatically corrects for negative entries in `b` to maintain feasibility
- Applied Bland's Rule for tie-breaking in entering variable selection
- Detects unbounded problems
- Provides verbose tableau display for each simplex iteration

## Example Usage
```bash
A = [1 2; 4 0; 0 4];
b = [8; 16; 12];
c = [-3; -5];

[x_opt, z_opt] = big_M_method(A, b, c);
```
## Output
The function prints:
- Initial simplex tableau
- Entering and leaving variables at each iteration
- Updated tableau after each pivot
- Final optimal solution vector and objective function value

## Notes
- A large constant `M` is automatically calculated based on the norms of `A` and `b` to avoid manual tuning.
- The method assumes all constraints are equalities (`Ax = b`). If your problem includes inequalities, you must first convert them.
