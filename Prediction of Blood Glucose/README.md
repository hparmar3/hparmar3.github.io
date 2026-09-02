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
