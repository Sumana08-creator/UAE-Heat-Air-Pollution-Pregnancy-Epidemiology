# ============================================================
# 11_cumulative_temperature_model.R
# Cumulative temperature exposure and preeclampsia
# ============================================================

# ------------------------------------------------------------
# 1. Load the lagged exposure dataset
# ------------------------------------------------------------

pregnancy_data <- read.csv(
  "03_Data/synthetic_pregnancy_cohort_lagged_exposure.csv"
)

# ------------------------------------------------------------
# 2. Restore categorical variables
# ------------------------------------------------------------

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

# ------------------------------------------------------------
# 3. Check the cumulative exposure variable
# ------------------------------------------------------------

summary(
  pregnancy_data$cumulative_temperature_exposure
)

# ------------------------------------------------------------
# 4. Fit the cumulative temperature model
# ------------------------------------------------------------

cumulative_temperature_model <- glm(
  preeclampsia_binary ~
    cumulative_temperature_exposure +
    mean_pm25 +
    maternal_age +
    trimester +
    region,
  data = pregnancy_data,
  family = binomial
)

# ------------------------------------------------------------
# 5. Display model results
# ------------------------------------------------------------

summary(
  cumulative_temperature_model
)

# ------------------------------------------------------------
# 6. Calculate odds ratio and 95% confidence interval
# ------------------------------------------------------------

cumulative_temperature_or <- exp(
  coef(cumulative_temperature_model)[
    "cumulative_temperature_exposure"
  ]
)

cumulative_temperature_ci <- exp(
  confint(
    cumulative_temperature_model,
    parm = "cumulative_temperature_exposure"
  )
)

cumulative_temperature_p <- summary(
  cumulative_temperature_model
)$coefficients[
  "cumulative_temperature_exposure",
  "Pr(>|z|)"
]

# ------------------------------------------------------------
# 7. Create a results table
# ------------------------------------------------------------

cumulative_temperature_results <- data.frame(
  Exposure = "Cumulative temperature exposure",
  Odds_Ratio = cumulative_temperature_or,
  CI_Lower = cumulative_temperature_ci[1],
  CI_Upper = cumulative_temperature_ci[2],
  P_Value = cumulative_temperature_p
)

print(
  cumulative_temperature_results
)

# ------------------------------------------------------------
# 8. Save the results
# ------------------------------------------------------------

write.csv(
  cumulative_temperature_results,
  "04_Results/cumulative_temperature_preeclampsia_results.csv",
  row.names = FALSE
)

cat(
  "\nCumulative temperature model results saved successfully.\n"
)