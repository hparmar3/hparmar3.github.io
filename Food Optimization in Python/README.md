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
