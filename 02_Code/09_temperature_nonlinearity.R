# ============================================================
# 09_temperature_nonlinearity.R
# Non-linear temperature and preeclampsia association
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

# Check the temperature distribution
summary(pregnancy_data$mean_temperature_c)

# Load spline package
library(splines)
# ------------------------------------------------------------
# Linear temperature model
# ------------------------------------------------------------

linear_temperature_model <- glm(
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
# Non-linear temperature model using natural splines
# ------------------------------------------------------------

spline_temperature_model <- glm(
  preeclampsia_binary ~
    ns(mean_temperature_c, df = 3) +
    mean_pm25 +
    maternal_age +
    trimester +
    region,
  data = pregnancy_data,
  family = binomial
)

# Display model comparison
anova(
  linear_temperature_model,
  spline_temperature_model,
  test = "Chisq"
)
# ------------------------------------------------------------
# Save non-linearity model comparison
# ------------------------------------------------------------

nonlinearity_test <- anova(
  linear_temperature_model,
  spline_temperature_model,
  test = "Chisq"
)

nonlinearity_results <- data.frame(
  Comparison = "Linear vs natural spline temperature model",
  Deviance = nonlinearity_test$Deviance[2],
  Degrees_of_Freedom = nonlinearity_test$Df[2],
  P_Value = nonlinearity_test$`Pr(>Chi)`[2]
)

print(nonlinearity_results)

write.csv(
  nonlinearity_results,
  "04_Results/temperature_nonlinearity_results.csv",
  row.names = FALSE
)

cat(
  "\nTemperature non-linearity results saved successfully.\n"
)