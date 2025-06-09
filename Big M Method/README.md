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
