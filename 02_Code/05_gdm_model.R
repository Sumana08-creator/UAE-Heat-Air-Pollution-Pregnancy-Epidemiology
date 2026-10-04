# ============================================================
# 05_gdm_model.R
# Gestational Diabetes and Environmental Exposure
# ============================================================

# Load data
pregnancy_data <- read.csv(
  "03_Data/synthetic_pregnancy_cohort.csv"
)

# Restore categorical variables
pregnancy_data$region <- factor(
  pregnancy_data$region
)

pregnancy_data$trimester <- factor(
  pregnancy_data$trimester,
  levels = c("First", "Second", "Third")
)

pregnancy_data$heat_exposure <- factor(
  pregnancy_data$heat_exposure
)

# Check outcome
table(pregnancy_data$gestational_diabetes_binary)

# ------------------------------------------------------------
# Main adjusted logistic regression model
# ------------------------------------------------------------

gdm_model <- glm(
  gestational_diabetes_binary ~
    mean_temperature_c +
    mean_pm25 +
    maternal_age +
    trimester +
    region,
  data = pregnancy_data,
  family = binomial
)

# Display model results
summary(gdm_model)

# ------------------------------------------------------------
# Calculate Odds Ratios and 95% Confidence Intervals
# ------------------------------------------------------------

gdm_results <- data.frame(
  Term = names(coef(gdm_model)),
  OR = exp(coef(gdm_model)),
  CI_Lower = exp(confint.default(gdm_model)[, 1]),
  CI_Upper = exp(confint.default(gdm_model)[, 2]),
  P_Value = summary(gdm_model)$coefficients[, 4]
)

print(gdm_results)

# ------------------------------------------------------------
# Save results
# ------------------------------------------------------------

write.csv(
  gdm_results,
  "04_Results/gdm_model_results.csv",
  row.names = FALSE
)

cat("\nGDM modelling completed successfully.\n")