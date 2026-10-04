# ============================================================
# 06_birthweight_model.R
# Birthweight and Environmental Exposure
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

# Check birthweight
summary(pregnancy_data$birthweight_g)

# ------------------------------------------------------------
# Main linear regression model
# ------------------------------------------------------------

birthweight_model <- lm(
  birthweight_g ~
    mean_temperature_c +
    mean_pm25 +
    maternal_age +
    trimester +
    region,
  data = pregnancy_data
)

# Display model results
summary(birthweight_model)

# ------------------------------------------------------------
# Extract coefficients and 95% confidence intervals
# ------------------------------------------------------------

birthweight_results <- data.frame(
  Term = names(coef(birthweight_model)),
  Estimate_g = coef(birthweight_model),
  CI_Lower = confint(birthweight_model)[, 1],
  CI_Upper = confint(birthweight_model)[, 2],
  P_Value = summary(birthweight_model)$coefficients[, 4]
)

print(birthweight_results)

# ------------------------------------------------------------
# Save results
# ------------------------------------------------------------

write.csv(
  birthweight_results,
  "04_Results/birthweight_model_results.csv",
  row.names = FALSE
)

cat("\nBirthweight modelling completed successfully.\n")