### Logistic Regression From Scratch

# Load required packages
library(ggplot2)

# Sigmoid function
sigmoid <- function(z) {
  1 / (1 + exp(-z))
}

# Logistic Regression using gradient descent
logistic_regression <- function(X, y, lr = 0.1, num_iter = 1000) {
  # Initialize weights and bias
  w <- rep(0, ncol(X))
  b <- 0
  
  for (i in 1:num_iter) {
    # Compute predictions
    z <- X %*% w + b
    y_pred <- sigmoid(z)
    error <- y_pred - y
    
    # Compute gradients
    dw <- t(X) %*% error / nrow(X)
    db <- sum(error) / nrow(X)
    
    # Update weights and bias
    w <- w - lr * dw
    b <- b - lr * db
  }
  
  list(weights = w, bias = b)
}

# Prediction function
predict_classes <- function(X, w, b, threshold = 0.5) {
  prob <- sigmoid(X %*% w + b)
  ifelse(prob >= threshold, 1, 0)
}

# Generate synthetic data
set.seed(42)
X <- cbind(
  x1 = rnorm(100),
  x2 = rnorm(100)
)
y <- ifelse(X[,1] + X[,2] > 0, 1, 0)

# Fit the model
model <- logistic_regression(X, y, lr = 0.1, num_iter = 1000)

# Predictions and accuracy
preds <- predict_classes(X, model$weights, model$bias)
acc <- mean(preds == y)
cat(sprintf("Accuracy: %.2f%%\n", acc * 100))

# Decision boundary visualization
df <- data.frame(x1 = X[,1], x2 = X[,2], label = as.factor(y))
xx1 <- seq(min(X[,1])-1, max(X[,1])+1, length.out = 100)
xx2 <- seq(min(X[,2])-1, max(X[,2])+1, length.out = 100)
grid <- expand.grid(x1 = xx1, x2 = xx2)
prob_grid <- sigmoid(as.matrix(grid) %*% model$weights + model$bias)
grid$label <- as.factor(ifelse(prob_grid >= 0.5, 1, 0))

ggplot() +
  geom_point(data = df, aes(x1, x2, color = label)) +
  geom_tile(data = grid, aes(x1, x2, fill = label), alpha = 0.2) +
  scale_color_manual(values = c("red","blue")) +
  scale_fill_manual(values = c("pink","lightblue")) +
  labs(
    title = "Logistic Regression Decision Boundary",
    x = "Feature X1",
    y = "Feature X2"
  ) +
  theme_minimal()

