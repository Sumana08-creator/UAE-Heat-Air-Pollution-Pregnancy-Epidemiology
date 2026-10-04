# ============================================================
# UAE Heat, Air Pollution and Pregnancy Epidemiology
# Step 1: Generate a Synthetic Pregnancy Cohort
#
# Purpose:
# Create a reproducible synthetic dataset for demonstrating
# environmental epidemiology methods in pregnancy.
#
# IMPORTANT:
# All data in this project are synthetic.
# They do NOT represent real UAE clinical or environmental data.
# ============================================================


# ------------------------------------------------------------
# 1. Reproducibility and sample size
# ------------------------------------------------------------

set.seed(2026)

n <- 10000


# ------------------------------------------------------------
# 2. Create basic pregnancy characteristics
# ------------------------------------------------------------

pregnancy_data <- data.frame(
  
  pregnancy_id = 1:n,
  
  maternal_age = round(
    runif(
      n,
      min = 18,
      max = 45
    ),
    1
  ),
  
  gestational_week = sample(
    4:40,
    n,
    replace = TRUE
  ),
  
  region = sample(
    c(
      "Dubai",
      "Abu Dhabi",
      "Sharjah"
    ),
    n,
    replace = TRUE,
    prob = c(
      0.45,
      0.35,
      0.20
    )
  )
)


# ------------------------------------------------------------
# 3. Generate synthetic temperature exposure
# ------------------------------------------------------------

pregnancy_data$mean_temperature_c <- round(
  rnorm(
    n,
    mean = 32,
    sd = 3
  ),
  1
)


# ------------------------------------------------------------
# 4. Generate synthetic PM2.5 exposure
# ------------------------------------------------------------

pregnancy_data$mean_pm25 <- round(
  pmax(
    rnorm(
      n,
      mean = 30,
      sd = 8
    ),
    5
  ),
  1
)


# ------------------------------------------------------------
# 5. Create heat exposure category
# ------------------------------------------------------------

pregnancy_data$heat_exposure <- ifelse(
  pregnancy_data$mean_temperature_c >= 35,
  "High",
  "Lower"
)


# ------------------------------------------------------------
# 6. Generate synthetic preeclampsia
# ------------------------------------------------------------
#
# The probability is deliberately constructed so that
# higher temperature and higher PM2.5 are associated with
# higher probability of preeclampsia.
#
# This is simulated data-generating logic, NOT a real
# epidemiological estimate.
# ------------------------------------------------------------

preeclampsia_probability <- plogis(
  -2.8 +
    0.12 *
    (pregnancy_data$mean_temperature_c - 32) +
    0.025 *
    (pregnancy_data$mean_pm25 - 30)
)

pregnancy_data$preeclampsia_binary <- rbinom(
  n,
  size = 1,
  prob = preeclampsia_probability
)

pregnancy_data$preeclampsia <- ifelse(
  pregnancy_data$preeclampsia_binary == 1,
  "Yes",
  "No"
)


# ------------------------------------------------------------
# 7. Generate synthetic gestational diabetes
# ------------------------------------------------------------
#
# Again, these relationships are simulated for
# methodological demonstration only.
# ------------------------------------------------------------

gestational_diabetes_probability <- plogis(
  -2.3 +
    0.06 *
    (pregnancy_data$mean_temperature_c - 32) +
    0.015 *
    (pregnancy_data$mean_pm25 - 30)
)

pregnancy_data$gestational_diabetes_binary <- rbinom(
  n,
  size = 1,
  prob = gestational_diabetes_probability
)

pregnancy_data$gestational_diabetes <- ifelse(
  pregnancy_data$gestational_diabetes_binary == 1,
  "Yes",
  "No"
)


# ------------------------------------------------------------
# 8. Generate synthetic birthweight
# ------------------------------------------------------------
#
# Higher temperature and PM2.5 are simulated to be associated
# with lower birthweight.
#
# This is NOT an estimate from real UAE data.
# ------------------------------------------------------------

birthweight_mean <- (
  3200 -
    35 *
    (pregnancy_data$mean_temperature_c - 32) -
    8 *
    (pregnancy_data$mean_pm25 - 30)
)

pregnancy_data$birthweight_g <- round(
  rnorm(
    n,
    mean = birthweight_mean,
    sd = 450
  )
)


# ------------------------------------------------------------
# 9. Create pregnancy trimester
# ------------------------------------------------------------

pregnancy_data$trimester <- ifelse(
  pregnancy_data$gestational_week <= 13,
  "First",
  ifelse(
    pregnancy_data$gestational_week <= 27,
    "Second",
    "Third"
  )
)


# ------------------------------------------------------------
# 10. Create trimester-specific temperature exposures
# ------------------------------------------------------------
#
# These are synthetic exposure-window variables.
# They are correlated with overall pregnancy temperature
# but include small random variation.
# ------------------------------------------------------------

pregnancy_data$temperature_first_trimester <- round(
  pregnancy_data$mean_temperature_c +
    rnorm(
      n,
      mean = 0,
      sd = 1.5
    ),
  1
)

pregnancy_data$temperature_second_trimester <- round(
  pregnancy_data$mean_temperature_c +
    rnorm(
      n,
      mean = 0,
      sd = 1.5
    ),
  1
)

pregnancy_data$temperature_third_trimester <- round(
  pregnancy_data$mean_temperature_c +
    rnorm(
      n,
      mean = 0,
      sd = 1.5
    ),
  1
)


# ------------------------------------------------------------
# 11. Convert categorical variables to factors
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
# 12. Basic quality checks
# ------------------------------------------------------------

stopifnot(
  nrow(pregnancy_data) == n
)

stopifnot(
  all(
    pregnancy_data$preeclampsia_binary %in% c(0, 1)
  )
)

stopifnot(
  all(
    pregnancy_data$gestational_diabetes_binary %in% c(0, 1)
  )
)

stopifnot(
  all(
    pregnancy_data$gestational_week >= 4 &
      pregnancy_data$gestational_week <= 40
  )
)


# ------------------------------------------------------------
# 13. Display basic descriptive information
# ------------------------------------------------------------

cat("\nSynthetic pregnancy cohort created successfully.\n")

cat("\nNumber of pregnancies:\n")
print(nrow(pregnancy_data))

cat("\nPregnancies by trimester:\n")
print(table(pregnancy_data$trimester))

cat("\nPreeclampsia:\n")
print(table(pregnancy_data$preeclampsia))

cat("\nGestational diabetes:\n")
print(table(pregnancy_data$gestational_diabetes))

cat("\nRegion:\n")
print(table(pregnancy_data$region))


# ------------------------------------------------------------
# 14. Save final synthetic dataset
# ------------------------------------------------------------

write.csv(
  pregnancy_data,
  "03_Data/synthetic_pregnancy_cohort.csv",
  row.names = FALSE
)


# ------------------------------------------------------------
# 15. Confirm output
# ------------------------------------------------------------

cat(
  "\nDataset saved to:\n",
  "03_Data/synthetic_pregnancy_cohort.csv\n"
)

cat(
  "\nNumber of variables:",
  ncol(pregnancy_data),
  "\n"
)

cat(
  "Number of observations:",
  nrow(pregnancy_data),
  "\n"
)

cat("\nSynthetic cohort generation complete.\n")
table(
  pregnancy_data$preeclampsia,
  pregnancy_data$gestational_diabetes
)
file.exists("03_Data/synthetic_pregnancy_cohort.csv")