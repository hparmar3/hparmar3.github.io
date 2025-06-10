# Diet Cost Optimization Using Linear Programming

This project demonstrates how to use **Linear Programming** to create a cost-effective daily diet that meets basic nutritional requirements. It utilizes the `PuLP` library to solve a constrained optimization problem and `matplotlib` to visualize the results.

## 📌 Problem Statement

Given a list of foods with their nutritional values and costs, determine the optimal number of servings for each food item that:
- **Minimizes total cost**
- Meets or exceeds daily requirements for **calories** and **protein**
- Stays within the upper limit for **fat**

## ✅ Requirements

Install the necessary libraries using:

```bash
pip install pulp matplotlib pandas
```
## Optimization Formulation
- <b> Objective: </b> Minimize `Total Cost = Σ (Servings_i × Cost_i)`
- <b> Constraints: </b>
  - Calories ≥ 2000 kcal
  - Protein 50 g
  - Fat ≤ 70 g
  - Servings ≥ 0 (no negative food)

## 📋 Food Data

| Food           | Cost ($) | Calories | Protein (g) | Fat (g) |
|----------------|----------|----------|-------------|---------|
| Chicken Breast | 2.00     | 165      | 31.0        | 3.6     |
| Rice           | 0.50     | 206      | 4.2         | 0.4     |
| Broccoli       | 0.75     | 55       | 3.7         | 0.3     |
| Milk           | 0.60     | 103      | 8.0         | 2.4     |
| Eggs           | 0.25     | 78       | 6.0         | 5.3     |

## Output
- Displays the optimal number of servings for each food
- Shows the total cost
- Plot a bar chart comparing intake vs. constraints for:
  - Calories (min)
  - Protein (min)
  - Fat (max)

Example Output:
```bash
Status: Optimal

Optimized Food Plan (servings):
Chicken Breast: 5.10 servings
Rice: 2.30 servings
Milk: 1.50 servings

Total cost: $13.30
```

## Requirements
Install the dependencies with:
```bash
pip install pulp matplotlib pandas
```
