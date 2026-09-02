# Prediction of Blood Glucose
## Abstract
In this project, I analyzed my continuous glucose monitoring (CGM) data to model the relationship between blood glucose levels and physiological inputs, specifically insulin and carbohydrate intake. The dataset was obtained from a Dexcom CGM export and processes to extract glucose readings along with estimated insulin and carbohydrate events derived from changes in glucose trends. A Hammerstein Box-Jenkins model was implemented to capture non-linear and time-dependent relationships between these variables. The model predicts glucose levels using past glucose values and nonlinear delay effects of insulin input. The results show that the model achieves a root mean squared error (RMSE) of approximately 8.62 mg/dL, indicating a reasonable predictive accuracy relative to physiological glucose variability. Overall, the findings support the ability of nonlinear time-series models to capture key dynamics in glucose regulation, consistent with the findings in biomedical modeling literature.

## Background
Continuous glucose monitoring systems provide high-resolution time series data that allow for detailed analysis of glucose regulation in individuals. Blood glucose levels are influenced by multiple physiological factors, primarily insulin administration and carbohydrate intake. Insulin generally reduces blood glucose by promoting cellular uptake, while carbohydrate intake increases glucose levels through digestion and absorption. However, these relationships are not instantaneous and involve delays, nonlinear responses, and feedback mechanisms.

Traditional linear models are often insufficient to capture the complexity of glucose-insulin dynamics. As a result, more advanced system identification approaches, such as nonlinear autoregressive models and Hammerstein-type models, have been proposed in the literature. The models allow for the representation of both nonlinear input effects and temporal dependencies in physiological systems.

The dataset used in this study was obtained from a Dexcom Clarity continuous glucose monitor export file. The data were processed in Python to extract glucose readings and estimate insulin and carbohydrate events based on observed rate-of-change patterns in glucose levels.

## Materials and Methods
The dataset was obtained from a Dexcom Clarity CGM export file (“Clairty_Export_Parmar_Henna_2026-04-13_013311.csv”). The data were processed using Python with the following libraries: pandas, numpy, scikit-learn, and matplotlib.

### Data Processing
Glucose values were extracted from the CGM dataset and filtered to remove invalid or non-positive readings. Insulin and carbohydrate values were estimated based on rapid changes in glucose levels using threshold-based detection of glucose rate-of-change. These estimates were further consolidated in discrete daily events to reduce noise and redundancy.

### Model Description
The modeling approach is based on a Hammerstein Box-Jenkins (BJ) structure, which incorporates both autoregressive glucose terms and nonlinear transformations of insulin input by incorporating both system dynamics and noise modeling. In this framework, the system output represented as:

$$
y(t) = y_d(t) + v(t)
$$

where $y_d(t)$ represents the deterministic process output and $v(t)$ represents the noise component. The process output is modeled using a linear dynamic system:

$$
y_d(t) = G(q^{-1})x(t)
$$

where $G(q^{-1}) is a transfer function in the background shift operator $q^{-1}$, and $x(t)$ is a nonlinear transformation of the input. The nonlinearity is introduced through a polynomial function:

$$
x(t) = \sum_{i=0}^{M} {\gamma}_i u^i(t)
$$

Where $u(t)$ resents insulin input and ${/gamma}_i$ are coefficients to be estimated. In this work, a simplified implementation of the structure was used, where lagged glucose values and polynomial transformation of insulin were included as features in the regression model.

The general structure of the model that was used in my code is:

$$
y(t) = f(y(t-1), y(t-2), u(t), u(t-1), u(t-2))
$$

where:
- $y(t)$ is glucose at time $t$
- $u(t)$ is insulin input
- paste glucose values capture temporal dependence
- nonlinear powers of insulin capture physiological nonlinearity

### Machine Learning Procedure
The dataset was split into training (80%) and testing (20%) subsets. Missing values were handled using constant imputation (zero replacement), and features were standardized using z-score normalization. A linear regression model was trained on the transformed feature space.

### Evaluation
Model performance was evaluated using root mean squared error (RMSE), defined as:

$$
RMSE = \sqrt{\frac{1}{n} \sum({y_i - y_i})^2}
$$

## Analysis
Summary statistics of the dataset were computed to provide context for the model inputs and outputs. The mean glucose level was approximately 185.8 mg/dL, indicating that the dataset includes a range of elevated glucose values. The average estimated carbohydrate intake per event was 69.9 grams, while the average estimated insulin dose was 31.27 units. These values reflect typical magnitudes of the physiological inputs and outputs used in the modeling process. Anecdotally, I have never given myself 31 units of insulin at one time ever, so the method of estimating carbs and insulin is not perfectly accurate.

### Figure 1: Predicted vs. Actual Glucose
<img width="391" height="287" alt="Figure 2026-04-25 161917" src="https://github.com/user-attachments/assets/528732c1-71cf-4347-8e81-ce27b89e7a30" />

The first figure compares predicted glucose value against actual glucose measurements from the test dataset. A reference identity line is included to indicate perfect prediction. The scatter plot shows that most predictions cluster near the identity line, indicating that the model captures the general relationship between predicted and observed glucose values. Some variability is present, reflecting physiological noise and model limitations.

### Figure 2: Glucose Over time (Actual vs. Predicted)
<img width="406" height="325" alt="Figure 2026-04-25 162405" src="https://github.com/user-attachments/assets/7e37044c-8f9f-4423-8df9-6560844872fc" />

The second figure shows glucose values over time for both actual and predicted outputs. The plot demonstrates that the models follow the general temporal trends in glucose fluctuations. While some deviations occur at peak values, the predicted curve aligns well with overall glucose dynamics.

### Figure 3: Glucose, Insulin, and Carbohydrate Events
<img width="405" height="325" alt="Figure 2026-04-25 162620" src="https://github.com/user-attachments/assets/eff3503a-7e7c-43f4-94a3-3b53d7effe24" />

The third figure displays glucose levels alongside estimated insulin and carbohydrate intake over time. Carbohydrate events correspond to upward spikes in glucose, while insulin events are associated with subsequent decreases. This visualization illustrates the physiological relationship between inputs and glucose response.

## Discussion





