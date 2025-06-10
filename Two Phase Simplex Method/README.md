# Two-Phase Simplex Method Solver
This MATLAB project implements the <b> Two-Phase Simplex Method </b> for solving linear programming (LP) problems in standard form:
```bash
minimize c'x
subject to Ax = b
x >= 0
```
This implementation uses <b> Bland's Rule </b> for pivot selection to avoid cycling and prints each simplex tableau iteration, helping users visualize and understand the solution process step-by-step.

## Features
- Full implementation of the <b> Two-Phase Simplex Algorithm </b> in MATLAB
- Detects and handels <b> infeasible </b> and <b> unbounded </b> LPs
- Implements <b> Bland's rule </b> to ensure convergence
- Prints each tableau for education/debugging purposes
- Modular design:
  - `two_phase_simplex`: main function
  - `simplex_method`: Phase 1 tableau solver
  - `simplex_method_given_basis`: Phase 2 continuation
  - `pivot`: performs pivot operation
 
  ## Files
  `two_phase_simplex.m`: main function to solve LPs using the two_phase_simplex method
  `simplex_method.m`: implements simplex iterations for Phase 1
  `simplex_method_given_basis.m`: continues simplex iterations for Phase 2
  `pivot.m`: helper function to perform tableau pivoting
