# Henna's Portfolio
## Welcome!
Hi, I'm Henna! This portfolio showcases my programming and data science projects acorss multiple languages and domains. Here you'll find examples of:
- Mathematical optimization with `MATLAB` and `Python`
- Data analysis with `R`
- Software development in `Java`
- Web development using `HTML`, `CSS`, and `JavaScript`

## Projects
### Machine Learning & Data Science
- **[Machine Learning from Scratch](Machine%20Learning%20from%20Scratch/)** 
  - A hands-on implementation of Logistic Regression and K-Means Clustering alogrithms coded entirely from scratch using NumPy. Demonstrates gradient descent optimization, decision boundary visualization, and cluster assignments without using Scikit-learn or other ML libraries.
  - **Technologies:** Python, NumPy, Matplotlib
  - **Key Features:** Sigmoid function & cross entropy loss, iterative centroid updates, visual analysis
- **[Diabetes Data Visualization](Diabetes%20Data%20Visualization/)**
  - Comprehensive data visualization and linear regression analysis pipeline for predicting diabetes progression. Includes feature inspection, correlation heatmap analysis, and model evaluation using MSE and R^2 metrics.
  - **Technologies:** Python, Pandas, Seaborn, Scikit-learn
  - **Key Features:** Exploratory data analysis, correlation analysis, actual vs. predicted visualization
- **[Logisitic Regression](Logisitic%20Regression/)**
  - Logistic Regression implementation built entirely from scratch in R with gradient descent optimization. Generates synthetic data for binary classification and visualizes the learned decision boundary.
  - **Technologies:** R, ggplot2
  - **Key Features:** Custom gradient descent, sigmoid function implementation, decision boundary plotting
- **[Prediction of Blood Glucose](Prediction%20of%20%20Blood%20Glucose/)**

### Mathematical Optimization
- **[Simplex Method](Simplex%20Method/)**
  - Standard Simplex Method implementation for solving linear programming problems in MATLAB. Uses Bland's Rule for pivoting slection to prevent cycling and provides verbose output in each iteration
  - **Technologies:** MATLAB
  - **Key Features:** Standard LP solver, Bland's Rule implementation, unbounded problem detection
- **[Big M Method](Big%20M%20Method/)**
  - MATLAB implementation of the Big M Method for solving linear programming problems involving equality constraints and artificial variables. Automatically handles infeasiblility with penalty terms.
  - **Technologies:** MATLAB
  - **Key Features:** Artifical variable handling, automatic M calculation, negative RHS correction
- **[Dual Simplex Method](Dual%20Simplex%20Method/)**
  - Dual Simplex Method implementation for solving linear programs when the initial solution is dual feasible but not primal feasible. Particularly useful for problems with negative RHS values.
  - **Technologies:** MATLAB
  - **Key Features:** Dual feasibility maintenance, primal infeasibility handling, optimal solution guarantee
- **[Two Phase Simplex Method](Two%20Phase%20Simplex%20Method/)** 
  -  Two-Phase Simplex algorithm that first finds a basic feasible solution (Phase 1) then optimizes the objective function (Phase 2). Detects infeasible and unbounded problems.
  -  **Technologies** MATLAB
  -  **Key Features:** Modular designs, Bland's Rule, phase-by-phase tableau visualization
- **[Food Optimization in Python](Food%20Optimization%20in%20Python/)**
  - Linear programming application for creating a cost-effective daily diet that meets nutritional requirements. Uses PuLP to minimize cost while satisfying constraints for calories, protein, and fat.
  - **Technologies:** Python, PuLP, Matplotlib, Pandas
  - **Key Features:** Constraint optimization, nutritional planning, cost minimization
- **[McDonald's Diet Optimization](Linear%20Programming%20for%20McDonald's%20Diet/)**
  - MATLAB-based linear programming solution to determine the least expensive combination of McDonald's menu items that satisfies nutritional constraints including calories, protein, vitamins, and minerals.
  - **Technologies:** MATLAB, linprog
  - **Key Features:** Real-world constraint modeling, nutritional optimization, cost-effective meal planning
- **[Steepest Descent Method](Steepest%20Descent%20Method/)**
  - Implementation of the Steepest Descent optimization algorithm for solving quadratic minimization problems. Iteratively updates estimates by moving in the direction of the negative gradient with analytically computed optimal step sizes.
  - **Technologies:** MATLAB
  - **Key Features:** Gradient-based optimization, symmmetric positive definite matrices, convergence analysis

### Simulation & Statistical Modeling
- **[Monte Carlo Simulation](Monte%20Carlo%20Simulation/)**
  - Statistical simulation techniques for modeling uncertainty and probabilistic systems using Monte Carlo methods. Demonstrates random sampling and numerical integration approaches.
  - **Technologies:** Python, NumPy
  - **Key Features:** Stochastic modeling, uncertainty quantification, probabilistic analysis
- **[Markov Chain](Markov%20Chain/)**
  - Markov chain-based text generation system that learns word sequence probabilities from classic literature and generates new random text. Demonstrates natural language processing fundamentals.
  - **Technologies:** Python, Jupyter Notebook
  - **Key Features:** Probabilistic language modeling, Project Gutenberg integration, sequence generation
- **[Moving Average](Moving%20Average/)**
  - LSTM-based trading strategy implementation in R using moving averages and technical indicators. Analyzes stock data (SPY) with feature engineering including RSI, MACD, Bollinger Bands, and volatility measures.
  - **Technologies:** R, quantmod, TTR, keras
  - **Key Features:** Time series analysis, technical indicators, deep learning for trading
- **[Probability Problem Solutions](Probability%20Problem%20Solutions/)**
- **[Computational Math](Computational%20Math/)**

### Web Development & Software Enginnering
- **[Technical Documentation Page](Technical%20Documentation/)**
  - Responsive technical documentation website demonstrating HTML, CSS, and web development fundamentals. Features a fixed navigation bar, semantic HTML structure, and anchor-based scrolling.
  - **Technologies:** HTML, CSS, JavaScript
  - **Key Features:** Responsive design, semnatic markup, navigation system, code snippets
- **[Guide Effort Tool Website](Guide%20Effort%20Tool%20Website/)**
  - Interactive Shiny Flexdashboard application for importing, processing, and visualizing clinical guide participation data across multiple studies. Including REDCap API integration and dynamic filtering.
  - **Technologies:** R, Shiny, Flexdashboard, Tidyverse, DT
  - **Key Features:** Data import from REDCap, interactive dashboard, summary statistics, participant tracking
- **[Maritime Signal Flags Visualizer](Project%201/)**
  - Interactive Java application for visualizing maritime signal flags (Alpha, India, and Victor). Uses StdDraw library for GUI programming with user-defined sizing and animation delays.
  - **Technologies:** Java, StdDraw
  - **Key Features:** GUI drawing, user input handling, geometric flag visualization, control flow demonstration


## Contact 
Feel free to reach out!
- Email: hennapparmar@gmail.com, hparmar3@jh.edu
- LinkedIn: https://www.linkedin.com/in/hennaparmar3/

## Notes
- Each project folder contains a `README` with more details on setup, usage, and explanations
- Some projects require specific environments or dependencies, which are listed in their respective `README` files
