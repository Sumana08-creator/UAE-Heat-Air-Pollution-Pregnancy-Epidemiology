# ============================================================
# 13_final_results_summary.R
# Final summary of key epidemiological findings
# ============================================================

# ------------------------------------------------------------
# 1. Load the main synthetic pregnancy cohort
# ------------------------------------------------------------

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
  pregnancy_data$heat_exposure,
  levels = c("Lower", "High")
)

# ------------------------------------------------------------
# 2. Create binary outcomes
# ------------------------------------------------------------

pregnancy_data$preeclampsia_binary <- ifelse(
  pregnancy_data$preeclampsia == "Yes",
  1,
  0
)

pregnancy_data$gestational_diabetes_binary <- ifelse(
  pregnancy_data$gestational_diabetes == "Yes",
  1,
  0
)

# ------------------------------------------------------------
# 3. Main adjusted preeclampsia model
# ------------------------------------------------------------

preeclampsia_model <- glm(
  preeclampsia_binary ~
    mean_temperature_c +
    mean_pm25 +
    maternal_age +
    trimester +
    region,
  data = pregnancy_data,
  family = binomial
)

temperature_or <- exp(
  coef(preeclampsia_model)[
    "mean_temperature_c"
  ]
)

temperature_ci <- exp(
  confint(
    preeclampsia_model,
    parm = "mean_temperature_c"
  )
)

temperature_p <- summary(
  preeclampsia_model
)$coefficients[
  "mean_temperature_c",
  "Pr(>|z|)"
]

# ------------------------------------------------------------
# 4. PM2.5 result from the same model
# ------------------------------------------------------------

pm25_or <- exp(
  coef(preeclampsia_model)[
    "mean_pm25"
  ]
)

pm25_ci <- exp(
  confint(
    preeclampsia_model,
    parm = "mean_pm25"
  )
)

pm25_p <- summary(
  preeclampsia_model
)$coefficients[
  "mean_pm25",
  "Pr(>|z|)"
]

# ------------------------------------------------------------
# 5. Gestational diabetes model
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

gdm_temperature_or <- exp(
  coef(gdm_model)[
    "mean_temperature_c"
  ]
)

gdm_temperature_ci <- exp(
  confint(
    gdm_model,
    parm = "mean_temperature_c"
  )
)

gdm_temperature_p <- summary(
  gdm_model
)$coefficients[
  "mean_temperature_c",
  "Pr(>|z|)"
]

# ------------------------------------------------------------
# 6. Birthweight model
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

birthweight_temperature_beta <- coef(
  birthweight_model
)[
  "mean_temperature_c"
]

birthweight_temperature_ci <- confint(
  birthweight_model,
  parm = "mean_temperature_c"
)

birthweight_temperature_p <- summary(
  birthweight_model
)$coefficients[
  "mean_temperature_c",
  "Pr(>|t|)"
]

# ------------------------------------------------------------
# 7. Load cumulative exposure dataset
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

# ------------------------------------------------------------
# 8. Cumulative temperature model
# ------------------------------------------------------------

cumulative_model <- glm(
  preeclampsia_binary ~
    cumulative_temperature_exposure +
    mean_pm25 +
    maternal_age +
    trimester +
    region,
  data = lagged_data,
  family = binomial
)

cumulative_or <- exp(
  coef(cumulative_model)[
    "cumulative_temperature_exposure"
  ]
)

cumulative_ci <- exp(
  confint(
    cumulative_model,
    parm = "cumulative_temperature_exposure"
  )
)

cumulative_p <- summary(
  cumulative_model
)$coefficients[
  "cumulative_temperature_exposure",
  "Pr(>|z|)"
]

# ------------------------------------------------------------
# 9. High versus lower heat exposure
# ------------------------------------------------------------

heat_model <- glm(
  preeclampsia_binary ~
    heat_exposure +
    mean_pm25 +
    maternal_age +
    trimester +
    region,
  data = pregnancy_data,
  family = binomial
)

heat_or <- exp(
  coef(heat_model)[
    "heat_exposureHigh"
  ]
)

heat_ci <- exp(
  confint(
    heat_model,
    parm = "heat_exposureHigh"
  )
)

heat_p <- summary(
  heat_model
)$coefficients[
  "heat_exposureHigh",
  "Pr(>|z|)"
]

# ------------------------------------------------------------
# 10. Create final key results table
# ------------------------------------------------------------

final_results <- data.frame(
  
  Analysis = c(
    "Temperature and preeclampsia",
    "PM2.5 and preeclampsia",
    "Temperature and gestational diabetes",
    "Temperature and birthweight",
    "Cumulative temperature and preeclampsia",
    "High versus lower heat and preeclampsia"
  ),
  
  Effect_Measure = c(
    "Odds Ratio",
    "Odds Ratio",
    "Odds Ratio",
    "Beta coefficient (grams)",
    "Odds Ratio",
    "Odds Ratio"
  ),
  
  Estimate = c(
    temperature_or,
    pm25_or,
    gdm_temperature_or,
    birthweight_temperature_beta,
    cumulative_or,
    heat_or
  ),
  
  CI_Lower = c(
    temperature_ci[1],
    pm25_ci[1],
    gdm_temperature_ci[1],
    birthweight_temperature_ci[1],
    cumulative_ci[1],
    heat_ci[1]
  ),
  
  CI_Upper = c(
    temperature_ci[2],
    pm25_ci[2],
    gdm_temperature_ci[2],
    birthweight_temperature_ci[2],
    cumulative_ci[2],
    heat_ci[2]
  ),
  
  P_Value = c(
    temperature_p,
    pm25_p,
    gdm_temperature_p,
    birthweight_temperature_p,
    cumulative_p,
    heat_p
  )
)

# ------------------------------------------------------------
# 11. Round results
# ------------------------------------------------------------

final_results$Estimate <- round(
  final_results$Estimate,
  3
)

final_results$CI_Lower <- round(
  final_results$CI_Lower,
  3
)

final_results$CI_Upper <- round(
  final_results$CI_Upper,
  3
)

# ------------------------------------------------------------
# 12. Create formatted effect estimate
# ------------------------------------------------------------

final_results$Estimate_95CI <- paste0(
  final_results$Estimate,
  " (",
  final_results$CI_Lower,
  "–",
  final_results$CI_Upper,
  ")"
)

# ------------------------------------------------------------
# 13. Display final results
# ------------------------------------------------------------

cat(
  "\n============================================\n"
)

cat(
  "FINAL KEY EPIDEMIOLOGICAL RESULTS\n"
)

cat(
  "============================================\n\n"
)

print(
  final_results[
    ,
    c(
      "Analysis",
      "Effect_Measure",
      "Estimate_95CI",
      "P_Value"
    )
  ]
)

# ------------------------------------------------------------
# 14. Save final results
# ------------------------------------------------------------

write.csv(
  final_results,
  "04_Results/final_key_epidemiological_results.csv",
  row.names = FALSE
)

# ------------------------------------------------------------
# 15. Create project analysis inventory
# ------------------------------------------------------------

analysis_inventory <- data.frame(
  
  Analysis_Number = 1:12,
  
  Analysis = c(
    "Synthetic pregnancy cohort generation",
    "Descriptive epidemiology",
    "Preeclampsia multivariable logistic regression",
    "Gestational diabetes multivariable logistic regression",
    "Birthweight linear regression",
    "Trimester-specific temperature analysis",
    "Temperature × trimester interaction",
    "Socioeconomic effect modification",
    "Green-space effect modification",
    "Temperature non-linearity",
    "Cumulative temperature exposure",
    "Sensitivity analysis"
  ),
  
  Status = rep(
    "Completed",
    12
  )
)

# ------------------------------------------------------------
# 16. Save analysis inventory
# ------------------------------------------------------------

write.csv(
  analysis_inventory,
  "04_Results/project_analysis_inventory.csv",
  row.names = FALSE
)

# ------------------------------------------------------------
# 17. Completion messages
# ------------------------------------------------------------

cat(
  "\nFinal key results saved successfully.\n"
)

cat(
  "\nProject analysis inventory saved successfully.\n"
)