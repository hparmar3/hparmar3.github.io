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
