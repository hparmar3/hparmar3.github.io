# Logistics Regression & K-Means From Scratch
A hands-on implementation of two classic machine learning alogrithms - Logistic Regression and K-Means Clusterings - coded entirely from scratch using NumPy.

> No Scikit-learn or other ML libraries were used!

## Overview
This project demonstrates:
- Implementing <b> Logistic Regression </b> (classification) using gradient descent
- Implementing <b> K-Means Clustering </b> (unsupervised learning) using iterative centroid updates
- Visualizing the <b> decision boundary </b> for logistic regression and <b> cluster assignments </b> for K-means
- Learning the math behind these algorithms and coding them manually to gain a deeper understanding

## Algorithms Implemented
### Logistics Regression
- Sigmoid function & corss-entropy loss
- Gradient descent optimization
- Decision boundary visualization on a toy dataset

<b> Math Recap: </b>
 
$\ \hat{y} = \sigma ({\omega}^T x + b), \sigma (z) = \frac{1}{1 + e^{-z}} \$


<b> Loss: </b>

$\ L = -\frac{1}{m} \sum [y log(\hat{y}) + (1-y) log (1 - \hat{y})] \$
​	

<b> Gradient Descent Updates: </b>

$\ w := w - alpha \frac{dL}{dw}, b:= b - \alpha \frac{dL}{db} \$

### K-Means Clustering
- Random centroid initialization
- Iterative assignment and centroid recomputation
- Cluster visualization on synthetic data (`make_blobs`)

## Results
### Logistic Regression Decision Boundary
- Plots the learned decision boundary separating two classes

### K-Means Clustering
- Plots synthetic data with color-coded clusters and centroid markers

### Requirements
- Python >= 3.7
- NumPy
- Matplotlib
- Scikit-learn (optional - for generating synthetic data)

