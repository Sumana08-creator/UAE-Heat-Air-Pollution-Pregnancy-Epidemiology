# ============================================================
# UAE Heat, Air Pollution and Pregnancy Epidemiology
# Step 3: Preeclampsia Regression Models
#
# IMPORTANT:
# All data are synthetic.
# Results demonstrate an epidemiological analysis workflow
# and do not represent real UAE clinical evidence.
# ============================================================


# ------------------------------------------------------------
# 1. Load the synthetic cohort
# ------------------------------------------------------------

pregnancy_data <- read.csv(
  "03_Data/synthetic_pregnancy_cohort.csv"
)


# ------------------------------------------------------------
# 2. Restore categorical variables
# ------------------------------------------------------------

pregnancy_data$region <- factor(
  pregnancy_data$region,
  levels = c(
    "Abu Dhabi",
    "Dubai",
    "Sharjah"
  )
)

pregnancy_data$trimester <- factor(
  pregnancy_data$trimester,
  levels = c(
    "First",
    "Second",
    "Third"
  )
)

pregnancy_data$heat_exposure <- factor(
  pregnancy_data$heat_exposure,
  levels = c(
    "Lower",
    "High"
  )
)


# ------------------------------------------------------------
# 3. Check the binary outcome
# ------------------------------------------------------------

table(
  pregnancy_data$preeclampsia_binary
)


# ------------------------------------------------------------
# MODEL 1
# Unadjusted association between temperature and
# preeclampsia
# ------------------------------------------------------------

model1 <- glm(
  preeclampsia_binary ~
    mean_temperature_c,
  data = pregnancy_data,
  family = binomial
)

summary(model1)


# ------------------------------------------------------------
# 4. Convert model coefficient to odds ratio
# ------------------------------------------------------------

model1_results <- data.frame(
  Exposure = "Mean temperature",
  OR = exp(
    coef(model1)["mean_temperature_c"]
  ),
  CI_Lower = exp(
    confint(model1)["mean_temperature_c", 1]
  ),
  CI_Upper = exp(
    confint(model1)["mean_temperature_c", 2]
  )
)

print(model1_results)


# ------------------------------------------------------------
# MODEL 2
# Temperature + PM2.5
# ------------------------------------------------------------

model2 <- glm(
  preeclampsia_binary ~
    mean_temperature_c +
    mean_pm25,
  data = pregnancy_data,
  family = binomial
)

summary(model2)


# ------------------------------------------------------------
# MODEL 3
# Fully adjusted model
#
# Temperature
# PM2.5
# Maternal age
# Trimester
# Region
# ------------------------------------------------------------

model3 <- glm(
  preeclampsia_binary ~
    mean_temperature_c +
    mean_pm25 +
    maternal_age +
    trimester +
    region,
  data = pregnancy_data,
  family = binomial
)

summary(model3)


# ------------------------------------------------------------
# 5. Extract adjusted odds ratios
# ------------------------------------------------------------

model3_coefficients <- summary(model3)$coefficients

model3_results <- data.frame(
  Term = rownames(model3_coefficients),
  OR = exp(
    model3_coefficients[, "Estimate"]
  ),
  CI_Lower = exp(
    model3_coefficients[, "Estimate"] -
      1.96 *
      model3_coefficients[, "Std. Error"]
  ),
  CI_Upper = exp(
    model3_coefficients[, "Estimate"] +
      1.96 *
      model3_coefficients[, "Std. Error"]
  ),
  P_Value = model3_coefficients[, "Pr(>|z|)"],
  row.names = NULL
)

print(model3_results)


# ------------------------------------------------------------
# 6. Compare model fit
# ------------------------------------------------------------

model_comparison <- data.frame(
  Model = c(
    "Model 1: Temperature only",
    "Model 2: Temperature + PM2.5",
    "Model 3: Fully adjusted"
  ),
  
  AIC = c(
    AIC(model1),
    AIC(model2),
    AIC(model3)
  )
)

print(model_comparison)


# ------------------------------------------------------------
# 7. Save model results
# ------------------------------------------------------------

write.csv(
  model1_results,
  "04_Results/preeclampsia_model1_temperature.csv",
  row.names = FALSE
)

write.csv(
  model3_results,
  "04_Results/preeclampsia_adjusted_model.csv",
  row.names = FALSE
)

write.csv(
  model_comparison,
  "04_Results/preeclampsia_model_comparison.csv",
  row.names = FALSE
)


# ------------------------------------------------------------
# 8. Completion message
# ------------------------------------------------------------

cat("\n==============================\n")
cat("PREECLAMPSIA MODELLING COMPLETE\n")
cat("==============================\n")
model_comparison