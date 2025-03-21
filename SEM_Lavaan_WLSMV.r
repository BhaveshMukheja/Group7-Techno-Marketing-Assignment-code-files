# The following code is used to run SEM analysis on the research data 
# sem_data is the modified file after data cleaning for seemless analysis


# Load the lavaan package
library(lavaan)

data<-read.csv('sem_data.csv')

# Define the SEM model
sem_model <- '
  # Measurement Model (Latent Variables)
  PE =~ PE3 + PE6 + PE7
  EE =~ EE3 + EE8 + EE9
  FC =~ FC1 + FC3 + FC5
  HT =~ HT1 + HT4 + HT6
  PV =~ PV2 + PV4 + PV5
  DWA =~ DWA1 + DWA2 + DWA3 + DWA4

  # Structural Model (Predicting DWA)
  DWA ~ PE + EE + FC + HT + PV
'

# Specify the ordinal variables
ordered_vars <- c("PE3", "PE6", "PE7", "EE3", "EE8", "EE9", 
                  "FC1", "FC3", "FC5", "HT1", "HT4", "HT6", 
                  "PV2", "PV4", "PV5", "DWA1", "DWA2", "DWA3", "DWA4")

# Run SEM using the WLSMV estimator
fit <- sem(sem_model, data = data, estimator = "WLSMV", ordered = ordered_vars)

# Summarize the results
summary(fit, fit.measures = TRUE, standardized = TRUE)