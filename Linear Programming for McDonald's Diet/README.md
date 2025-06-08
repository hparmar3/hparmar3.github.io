# Linear Programming for McDonal's Diet

This porject uses Linear Programming (LP) to determine the least expensive combination of McDonald's menu items that satisfies a set of nutritional constraints. Implemented in MATLAB, the optimization is performed using `linprog`, MATLAB's built-in LP solver.

## Problem Description
The goal is to <b> minimize the total cost </b> of "meal" while satisfying nutritional constraints such as calorie count, protein, iron, Vitamin C, calcium, and sodium.

Five food items considered:

1. Big Mac - $5.29
2. Cheeseburger - $2.99
3. Hamburger - $2.69
4. Quarter Pounder with Cheese - $5.43
5. Coke - $2.59

## Model Formulation
Minimize total cost:
```bash
c = [5.29, 2.99, 2.69, 5.43, 2.59];
```

## Nutrional Constraints Matrix(`A`) and Bound(`b`)
Each row in `A` represent a nutritional constraint (e.g., minimum/maximum intake), and each column corresponds to a food item. `b` holds the respective upper bounds:
```bash
A = [
    -590, -170, -140, -310, -150;   % Calories ≥ 2000
    -46, -10, -18, -30, -39;        % Protein ≥ 275g
    -25, -9, -2, -17, 0;            % Iron ≥ 50mg
    34, 10, 8, 13, 0;               % Vitamin C ≤ 78mg
    85, 25, 0, 250, 0;              % Calcium ≤ 300mg
    1050, 330, 310, 770, 40         % Sodium ≤ 2300mg
];
b = [-2000; -275; -50; 78; 300; 2300];
```

## Features
- Feature 1
- Feature 2

## Getting Started

### Installation

```bash
pip install -r requirements.txt

