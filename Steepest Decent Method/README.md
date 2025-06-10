# Steepest Descent Method (MATLAB)
This project implements the <b> Steepest Descent </b> optimization algorithm in MATLAB to solve quadratic minimization problems of the form:
```bash
minimize f(x) = f(x) = ½ * xᵗAx + bᵗx
where A is symmetric positive definite
```
## Problem Description
The steepest descent method iteratively updates an estimates of the minimizer `x` of a quadratic function by moving in the direction of the negative gradient

This implementation:
- computes the <b> optimal step size </b> analytically at each iteration
- ensure matrix `A` is <b> symmetric positive definite </b>
- logs results at key iterations for insight into convergence

## Mathematical Background
The update rule is:
```bash
x_{k+1} = x_k - α_k ∇f(x_k)
```
Where:
- `∇f(x_k) = A*x_k + b` (gradient of the function)
- `α_k = (∇fᵗ ∇f) / (∇fᵗ A ∇f)` (optimal step size)

## Overview
### Inputs
```bash
steepest_descent(A, b, x0, max_iter)
```
- `A` - symmetric positive definite matrix (`n x n`)
- `b` - linear coefficient vector (`n x 1`)
- `x0` - initial guess (`n x 1`)
- `max_iter ` - maximum number of iterations (integer)

### Outputs

- prints `x_k` and function value  `f(x_k)` at iterations 5, 10, and 15
- internal console logs track the optimization progress

## Example
### Inputs
```bash
A = [4, 1; 1, 3];
b = [-1; -2];
x0 = [2; 1];
max_iter = 20;

steepest_descent(A, b, x0, max_iter);
```
### Output
```bash
Iteration Results:
-------------------
Iteration 5: (x) = (0.1864, -0.5263), f(x) = -1.8698
Iteration 10: (x) = (0.2345, -0.5688), f(x) = -1.8759
Iteration 15: (x) = (0.2381, -0.5714), f(x) = -1.8759
```

## Requirements
- MATLAB
