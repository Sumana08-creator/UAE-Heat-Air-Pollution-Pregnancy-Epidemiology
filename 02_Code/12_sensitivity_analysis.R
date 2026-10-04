# ============================================================
# 12_sensitivity_analysis.R
# Sensitivity analysis of temperature and preeclampsia
# ============================================================

# ------------------------------------------------------------
# 1. Load the original pregnancy cohort
# ------------------------------------------------------------

pregnancy_data <- read.csv(
  "03_Data/synthetic_pregnancy_cohort.csv"
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
  pregnancy_data$heat_exposure,
  levels = c("Lower", "High")
)

# ------------------------------------------------------------
# 3. Model 1: Overall mean temperature
# ------------------------------------------------------------

overall_temperature_model <- glm(
  preeclampsia_binary ~
    mean_temperature_c +
    mean_pm25 +
    maternal_age +
    trimester +
    region,
  data = pregnancy_data,
  family = binomial
)

# ------------------------------------------------------------
# 4. Model 2: Cumulative temperature exposure
# ------------------------------------------------------------

lagged_data <- read.csv(
  "03_Data/synthetic_pregnancy_cohort_lagged_exposure.csv"
)

lagged_data$region <- factor(
  lagged_data$region
)

lagged_data$trimester <- factor(
  lagged_data$trimester,
  levels = c("First", "Second", "Third")
)

lagged_data$heat_exposure <- factor(
  lagged_data$heat_exposure,
  levels = c("Lower", "High")
)

cumulative_temperature_model <- glm(
  preeclampsia_binary ~
    cumulative_temperature_exposure +
    mean_pm25 +
    maternal_age +
    trimester +
    region,
  data = lagged_data,
  family = binomial
)

# ------------------------------------------------------------
# 5. Model 3: High versus lower heat exposure
# ------------------------------------------------------------

heat_exposure_model <- glm(
  preeclampsia_binary ~
    heat_exposure +
    mean_pm25 +
    maternal_age +
    trimester +
    region,
  data = pregnancy_data,
  family = binomial
)

# ------------------------------------------------------------
# 6. Extract odds ratios and confidence intervals
# ------------------------------------------------------------

overall_or <- exp(
  coef(overall_temperature_model)[
    "mean_temperature_c"
  ]
)

overall_ci <- exp(
  confint(
    overall_temperature_model,
    parm = "mean_temperature_c"
  )
)

overall_p <- summary(
  overall_temperature_model
)$coefficients[
  "mean_temperature_c",
  "Pr(>|z|)"
]

cumulative_or <- exp(
  coef(cumulative_temperature_model)[
    "cumulative_temperature_exposure"
  ]
)

cumulative_ci <- exp(
  confint(
    cumulative_temperature_model,
    parm = "cumulative_temperature_exposure"
  )
)

cumulative_p <- summary(
  cumulative_temperature_model
)$coefficients[
  "cumulative_temperature_exposure",
  "Pr(>|z|)"
]

heat_or <- exp(
  coef(heat_exposure_model)[
    "heat_exposureHigh"
  ]
)

heat_ci <- exp(
  confint(
    heat_exposure_model,
    parm = "heat_exposureHigh"
  )
)

heat_p <- summary(
  heat_exposure_model
)$coefficients[
  "heat_exposureHigh",
  "Pr(>|z|)"
]

# ------------------------------------------------------------
# 7. Create sensitivity analysis results table
# ------------------------------------------------------------

sensitivity_results <- data.frame(
  Exposure_Metric = c(
    "Overall mean temperature",
    "Cumulative temperature exposure",
    "High vs lower heat exposure"
  ),
  Odds_Ratio = c(
    overall_or,
    cumulative_or,
    heat_or
  ),
  CI_Lower = c(
    overall_ci[1],
    cumulative_ci[1],
    heat_ci[1]
  ),
  CI_Upper = c(
    overall_ci[2],
    cumulative_ci[2],
    heat_ci[2]
  ),
  P_Value = c(
    overall_p,
    cumulative_p,
    heat_p
  )
)

# ------------------------------------------------------------
# 8. Display results
# ------------------------------------------------------------

print(
  sensitivity_results
)

# ------------------------------------------------------------
# 9. Save results
# ------------------------------------------------------------

write.csv(
  sensitivity_results,
  "04_Results/temperature_sensitivity_analysis.csv",
  row.names = FALSE
)

cat(
  "\nSensitivity analysis results saved successfully.\n"
)