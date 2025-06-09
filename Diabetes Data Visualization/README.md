# Diabetes Data Visualization & Linear Regression Analysis
This file provides a simple pipeline for visualizing and modeling the <b> Diabetes dataset </b> using Python. The project demonstrates data inspection, correlation analysis, and the application of <b> linear regression </b> to predict disease progression.

## Overview
Using the diabetes dataset from `scikit-learn`, this notebook explores:
- Feature inspection and data distribution
- Correlation heatmap for exploratory data analysis
- Linear regression modeling
- Evaluation of prediction performance using MSE and R^2
- Visualization of actual vs. predicted progression values

## File
- `Diabetes_Data_Visualization.ipynb` - Main notebook containing all code and outputs

## Dependencies
This project uses standard Python libraries:
```bash
pandas
numpy
matplotlib
seaborn
scikit-learn
```

## Dataset
- `load_diabetes()` from `sklearn.datasets`
- Includes 442 samples, 10 baseline variables (e.g., age, BMI), and a quantitative measure of disease progression one year after baseline.

## Key Sections
### 1. Data Loading and Inspection
- Loads data into `pandas` DataFrame
- Displays summary statistics of features and target variable

### 2. Correlation Heatmap
- Uses `seaborn.heatmap()` to show relationships between features and target

### 3. Modeling with Linear Regression
- Splits data into training and test sets (80/20)
- Fits a `LinearRegression` model
- Evaluates predictions using:
  - <b> Mean Squared Error (MSE) </b>
  - <b> R^2 Score </b>

### 4. Prediction Visualization
- Scatter plot comparing actual vs. predicted values
- Red dashed line shows ideal predictions (y = x)

## Sample Output
```bash
Mean Squared Error: 2900.20
R^2 Score: 0.45
```
