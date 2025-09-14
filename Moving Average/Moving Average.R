# ======================================
# LSTM-Based Trading Strategy in R
# ======================================

library(quantmod)
library(TTR)
library(dplyr)
library(xts)
library(PerformanceAnalytics)
library(keras)

# Load SPY data
getSymbols("SPY", from = "2010-01-01")
data <- na.omit(SPY)

#Feature engineering
df <- data.frame(
  date = index(data),
  close = Cl(data),
  ma150 = SMA(Cl(data), 150),
  rsi = RSI(Cl(data), 14),
  macd = MACD(Cl(data))$macd,
  signal_line = MACD(Cl(data))$signal,
  vol = runSD(Cl(data), 20),
  bb_up = BBands(Cl(data))$up,
  bb_dn = BBands(Cl(data))$dn,
  return_1d = dailyReturn(Cl(data), type = "log")
)

names(df) <- c(
  "date",
  "close",
  "ma150",
  "rsi",
  "macd",
  "signal_line",
  "vol",
  "bb_up",
  "bb_dn",
  "return_1d"
)

df <- df %>%
  mutate(
    return_next_day = lead(return_1d, 1),
    target = ifelse(return_next_day > 0, 1, 0)
  ) %>%
  na.omit()

# Normalize features
normalize <- function(x) (x - mean(x)) / sd(x)
features <- df %>%
  select(close, ma150, rsi, macd, signal_line, vol, bb_up, bb_dn) %>%
  mutate(across(everything(), normalize))

# Parameters
lookback <- 10
n_features <- ncol(features)

# Function to create sequences
create_sequences <- function(x, y, lookback) {
  n <- nrow(x) - lookback
  X <- array(0, dim = c(n, lookback, ncol(x)))
  Y <- numeric(n)
  for (i in 1:n) {
    X[i,,] <- as.matrix(x[i:(i + lookback - 1), ])
    Y[i] <- y[i + lookback]
  }
  list(X = X, Y= Y)
}

# Create sequences
seqs <- create_sequences(features, df$target, lookback)
dates_seq <- df$date[(lookback + 1):nrow(df)]
returns_seq <- df$return_1d[(lookback + 1):nrow(df)]

# Train/test split
split_idx <- which(dates_seq >= as.Date("2020-01-01"))
X_train <- seqs$X[1:(split_idx - 1),,, drop = FALSE]
y_train <- seqs$Y[1:(split_idx - 1)]

X_test <- seqs$X[split_idx:length(seqs$Y), , , drop = FALSE]
y_test <- seqs$Y[split_idx:length(seqs$Y)]
dates_test <- dates_seq[split_idx:length(seqs$Y)]
returns_test <- returns_seq[split_idx:length(seqs$Y)]

# Build LSTM model
model <- keras_model_sequential() %>%
  layer_lstm(units = 50, input_shape = c(lookback, n_features), return_sequences = FALSE) %>%
  layer_dropout(rate = 0.3) %>%
  layer_dense(units = 1, activation = "sigmoid")

model %>% compile(
  loss = "binary_crossentropy",
  optimizer = optimizer_adam(learning_rate = 0.001),
  metrics = c("accuracy")
)

# Train model
history <- model %>% fit(
  X_train, y_train,
  epochs = 30,
  batch_size = 32,
  validation_split = 0.2,
  verbose = 1
)

# Predict and simulate
pred_probs <- model %>% predict(X_test)
signal <- ifelse(pred_probs > 0.55, 1, 0)
strategy_returns <- returns_test * lag(signal, default = 0)

# Evaluate
charts.PerformanceSummary(
  merge(
    xts(strategy_returns, order.by = dates_test),
    xts(returns_test, order.by = dates_test)
  ),
  legend.loc = "topleft",
  main = "LSTM Strategy vs Benchmark"
)

# ======================================
# 150-Day Moving Average Estimates from 2013
# ======================================
library(quantmod)
library(TTR)
library(PerformanceAnalytics)

# Load SPY data
getSymbols("SPY", from = Sys.Date() - 365*10)
prices <- Cl(SPY)

# Compute 150-day MA
ma150 <- SMA(prices, n = 150)

# Initialize
initial_capital <- 1e6
cash <- initial_capital
shares <- 0
equity <- numeric(length(prices))

# Loop through each day
for (i in 1:length(prices)) {
  price <- as.numeric(prices[i])
  signal <- ifelse(!is.na(ma150[i]) && price > ma150[i], 1, 0)
  
  if (signal == 1 && shares == 0) {
    # Buy SPY with all available cash
    shares <- cash / price
    cash <- 0
  } else if (signal == 0 && shares > 0) {
    # Sell all SPY and keep cash
    cash <- shares * price
    shares <- 0
  }
  
  # Equity = cash + value of shares
  equity[i] <- cash + shares * price
}

equity <- na.omit(equity)
equity_xts <- xts(equity, order.by = index(prices)[!is.na(equity)])

# Performance metrics
returns <- dailyReturn(equity_xts, type = "log")
annualized_ret <- Return.annualized(returns)
max_dd <- maxDrawdown(returns)
final_capital <- tail(equity_xts, 1)

cat("Final Capital: $", round(final_capital,2), "\n")
cat("Annualized Return: ", round(annualized_ret*100,2), "%\n")
cat("Max Drawdown: ", round(max_dd*100,2), "%\n")

# Plot
chart.CumReturns(
  merge(returns, dailyReturn(prices)),
  wealth.index = TRUE,
  main = "150-Day MA Strategy vs Buy-and-Hold SPY",
  legend.loc = "topleft",
  col = c("blue", "black")
)

# ======================================
# 150-Day Moving Average Estimates from 2003
# ======================================
library(quantmod)
library(TTR)

# Pull SPY data back to 2005 so SMA has enough lookback before 2008
getSymbols("SPY", from = "2005-01-01", to = Sys.Date(), src = "yahoo")

prices <- Cl(SPY)
ma150  <- SMA(prices, 150)

# Backtest
equity <- rep(NA, length(prices))
cash   <- 1e6
shares <- 0

for (i in 1:length(prices)) {
  price  <- as.numeric(prices[i])
  signal <- ifelse(!is.na(ma150[i]) && price > ma150[i], 1, 0)
  
  if (signal == 1 && shares == 0) {
    # Buy
    shares <- cash / price
    cash   <- 0
  } else if (signal == 0 && shares > 0) {
    # Sell
    cash   <- shares * price
    shares <- 0
  }
  
  equity[i] <- cash + shares * price
}

# Buy & Hold for comparison
buyhold <- 1e6 * as.numeric(prices) / as.numeric(prices[1])

# Plot
plot(index(prices), buyhold, type = "l", col = "black", lwd = 2,
     main = "SPY: Buy & Hold vs 150-Day SMA Strategy",
     xlab = "Date", ylab = "Portfolio Value ($)")
lines(index(prices), equity, col = "blue", lwd = 2)
legend("topleft", legend = c("Buy & Hold", "150-Day SMA"),
       col = c("black", "blue"), lwd = 2, bty = "n")

# ======================================
# 90-Day Moving Average Estimates from 2003
# ======================================
library(quantmod)
library(TTR)

# Pull SPY data back to 2005 so SMA has enough lookback before 2008
getSymbols("SPY", from = "2005-01-01", to = Sys.Date(), src = "yahoo")

prices <- Cl(SPY)
ma150  <- SMA(prices, 90)

# Backtest
equity <- rep(NA, length(prices))
cash   <- 1e6
shares <- 0

for (i in 1:length(prices)) {
  price  <- as.numeric(prices[i])
  signal <- ifelse(!is.na(ma150[i]) && price > ma150[i], 1, 0)
  
  if (signal == 1 && shares == 0) {
    # Buy
    shares <- cash / price
    cash   <- 0
  } else if (signal == 0 && shares > 0) {
    # Sell
    cash   <- shares * price
    shares <- 0
  }
  
  equity[i] <- cash + shares * price
}

# Buy & Hold for comparison
buyhold <- 1e6 * as.numeric(prices) / as.numeric(prices[1])

# Plot
plot(index(prices), buyhold, type = "l", col = "black", lwd = 2,
     main = "SPY: Buy & Hold vs 90-Day SMA Strategy",
     xlab = "Date", ylab = "Portfolio Value ($)")
lines(index(prices), equity, col = "blue", lwd = 2)
legend("topleft", legend = c("Buy & Hold", "90-Day SMA"),
       col = c("black", "blue"), lwd = 2, bty = "n")


# ======================================
# 30-Day Moving Average Estimates from 2003
# ======================================
library(quantmod)
library(TTR)

# Pull SPY data back to 2005 so SMA has enough lookback before 2008
getSymbols("SPY", from = "2005-01-01", to = Sys.Date(), src = "yahoo")

prices <- Cl(SPY)
ma150  <- SMA(prices, 30)

# Backtest
equity <- rep(NA, length(prices))
cash   <- 1e6
shares <- 0

for (i in 1:length(prices)) {
  price  <- as.numeric(prices[i])
  signal <- ifelse(!is.na(ma150[i]) && price > ma150[i], 1, 0)
  
  if (signal == 1 && shares == 0) {
    # Buy
    shares <- cash / price
    cash   <- 0
  } else if (signal == 0 && shares > 0) {
    # Sell
    cash   <- shares * price
    shares <- 0
  }
  
  equity[i] <- cash + shares * price
}

# Buy & Hold for comparison
buyhold <- 1e6 * as.numeric(prices) / as.numeric(prices[1])

# Plot
plot(index(prices), buyhold, type = "l", col = "black", lwd = 2,
     main = "SPY: Buy & Hold vs 30-Day SMA Strategy",
     xlab = "Date", ylab = "Portfolio Value ($)")
lines(index(prices), equity, col = "blue", lwd = 2)
legend("topleft", legend = c("Buy & Hold", "30-Day SMA"),
       col = c("black", "blue"), lwd = 2, bty = "n")

# ======================================
# 80-Day Moving Average Estimates from 2003
# ======================================
library(quantmod)
library(TTR)

# Pull SPY data back to 2005 so SMA has enough lookback before 2008
getSymbols("SPY", from = "2005-01-01", to = Sys.Date(), src = "yahoo")

prices <- Cl(SPY)
ma150  <- SMA(prices, 80)

# Backtest
equity <- rep(NA, length(prices))
cash   <- 1e6
shares <- 0

for (i in 1:length(prices)) {
  price  <- as.numeric(prices[i])
  signal <- ifelse(!is.na(ma150[i]) && price > ma150[i], 1, 0)
  
  if (signal == 1 && shares == 0) {
    # Buy
    shares <- cash / price
    cash   <- 0
  } else if (signal == 0 && shares > 0) {
    # Sell
    cash   <- shares * price
    shares <- 0
  }
  
  equity[i] <- cash + shares * price
}

# Buy & Hold for comparison
buyhold <- 1e6 * as.numeric(prices) / as.numeric(prices[1])

# Plot
plot(index(prices), buyhold, type = "l", col = "black", lwd = 2,
     main = "SPY: Buy & Hold vs 80-Day SMA Strategy",
     xlab = "Date", ylab = "Portfolio Value ($)")
lines(index(prices), equity, col = "blue", lwd = 2)
legend("topleft", legend = c("Buy & Hold", "80-Day SMA"),
       col = c("black", "blue"), lwd = 2, bty = "n")

# ======================================
# 60-Day Moving Average Estimates from 2003
# ======================================
library(quantmod)
library(TTR)

# Pull SPY data back to 2005 so SMA has enough lookback before 2008
getSymbols("SPY", from = "2005-01-01", to = Sys.Date(), src = "yahoo")

prices <- Cl(SPY)
ma150  <- SMA(prices, 60)

# Backtest
equity <- rep(NA, length(prices))
cash   <- 1e6
shares <- 0

for (i in 1:length(prices)) {
  price  <- as.numeric(prices[i])
  signal <- ifelse(!is.na(ma150[i]) && price > ma150[i], 1, 0)
  
  if (signal == 1 && shares == 0) {
    # Buy
    shares <- cash / price
    cash   <- 0
  } else if (signal == 0 && shares > 0) {
    # Sell
    cash   <- shares * price
    shares <- 0
  }
  
  equity[i] <- cash + shares * price
}

# Buy & Hold for comparison
buyhold <- 1e6 * as.numeric(prices) / as.numeric(prices[1])

# Plot
plot(index(prices), buyhold, type = "l", col = "black", lwd = 2,
     main = "SPY: Buy & Hold vs 60-Day SMA Strategy",
     xlab = "Date", ylab = "Portfolio Value ($)")
lines(index(prices), equity, col = "blue", lwd = 2)
legend("topleft", legend = c("Buy & Hold", "60-Day SMA"),
       col = c("black", "blue"), lwd = 2, bty = "n")
