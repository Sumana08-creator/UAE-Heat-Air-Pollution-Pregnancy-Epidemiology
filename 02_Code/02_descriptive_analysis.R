# ============================================================
# UAE Heat, Air Pollution and Pregnancy Epidemiology
# Step 2: Descriptive Epidemiology
#
# Purpose:
# Describe the synthetic pregnancy cohort before modelling.
#
# IMPORTANT:
# All data are synthetic and are used only to demonstrate
# environmental epidemiology methods.
# ============================================================


# ------------------------------------------------------------
# 1. Load the synthetic cohort
# ------------------------------------------------------------

pregnancy_data <- read.csv(
  "03_Data/synthetic_pregnancy_cohort.csv"
)


# ------------------------------------------------------------
# 2. Restore categorical variables as factors
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
# 3. Basic cohort size
# ------------------------------------------------------------

cat("\n==============================\n")
cat("COHORT SIZE\n")
cat("==============================\n")

cat(
  "Number of pregnancies:",
  nrow(pregnancy_data),
  "\n"
)


# ------------------------------------------------------------
# 4. Continuous variable summary
# ------------------------------------------------------------

cat("\n==============================\n")
cat("CONTINUOUS VARIABLES\n")
cat("==============================\n")

summary(
  pregnancy_data[
    ,
    c(
      "maternal_age",
      "gestational_week",
      "mean_temperature_c",
      "mean_pm25",
      "birthweight_g"
    )
  ]
)


# ------------------------------------------------------------
# 5. Trimester distribution
# ------------------------------------------------------------

cat("\n==============================\n")
cat("TRIMESTER DISTRIBUTION\n")
cat("==============================\n")

trimester_counts <- table(
  pregnancy_data$trimester
)

print(trimester_counts)

trimester_percent <- round(
  prop.table(trimester_counts) * 100,
  2
)

print(trimester_percent)


# ------------------------------------------------------------
# 6. Region distribution
# ------------------------------------------------------------

cat("\n==============================\n")
cat("REGION DISTRIBUTION\n")
cat("==============================\n")

region_counts <- table(
  pregnancy_data$region
)

print(region_counts)

region_percent <- round(
  prop.table(region_counts) * 100,
  2
)

print(region_percent)


# ------------------------------------------------------------
# 7. Heat exposure distribution
# ------------------------------------------------------------

cat("\n==============================\n")
cat("HEAT EXPOSURE\n")
cat("==============================\n")

heat_counts <- table(
  pregnancy_data$heat_exposure
)

print(heat_counts)

heat_percent <- round(
  prop.table(heat_counts) * 100,
  2
)

print(heat_percent)


# ------------------------------------------------------------
# 8. Preeclampsia distribution
# ------------------------------------------------------------

cat("\n==============================\n")
cat("PREECLAMPSIA\n")
cat("==============================\n")

preeclampsia_counts <- table(
  pregnancy_data$preeclampsia
)

print(preeclampsia_counts)

preeclampsia_percent <- round(
  prop.table(preeclampsia_counts) * 100,
  2
)

print(preeclampsia_percent)


# ------------------------------------------------------------
# 9. Gestational diabetes distribution
# ------------------------------------------------------------

cat("\n==============================\n")
cat("GESTATIONAL DIABETES\n")
cat("==============================\n")

gdm_counts <- table(
  pregnancy_data$gestational_diabetes
)

print(gdm_counts)

gdm_percent <- round(
  prop.table(gdm_counts) * 100,
  2
)

print(gdm_percent)


# ------------------------------------------------------------
# 10. Temperature by preeclampsia status
# ------------------------------------------------------------

cat("\n==============================\n")
cat("TEMPERATURE BY PREECLAMPSIA STATUS\n")
cat("==============================\n")

temperature_by_preeclampsia <- aggregate(
  mean_temperature_c ~ preeclampsia,
  data = pregnancy_data,
  FUN = mean
)

print(temperature_by_preeclampsia)


# ------------------------------------------------------------
# 11. PM2.5 by preeclampsia status
# ------------------------------------------------------------

cat("\n==============================\n")
cat("PM2.5 BY PREECLAMPSIA STATUS\n")
cat("==============================\n")

pm25_by_preeclampsia <- aggregate(
  mean_pm25 ~ preeclampsia,
  data = pregnancy_data,
  FUN = mean
)

print(pm25_by_preeclampsia)


# ------------------------------------------------------------
# 12. Birthweight by preeclampsia status
# ------------------------------------------------------------

cat("\n==============================\n")
cat("BIRTHWEIGHT BY PREECLAMPSIA STATUS\n")
cat("==============================\n")

birthweight_by_preeclampsia <- aggregate(
  birthweight_g ~ preeclampsia,
  data = pregnancy_data,
  FUN = mean
)

print(birthweight_by_preeclampsia)


# ------------------------------------------------------------
# 13. Temperature by trimester
# ------------------------------------------------------------

cat("\n==============================\n")
cat("TEMPERATURE BY TRIMESTER\n")
cat("==============================\n")

temperature_by_trimester <- aggregate(
  mean_temperature_c ~ trimester,
  data = pregnancy_data,
  FUN = mean
)

print(temperature_by_trimester)


# ------------------------------------------------------------
# 14. Exposure-window correlations
# ------------------------------------------------------------

cat("\n==============================\n")
cat("TRIMESTER TEMPERATURE CORRELATIONS\n")
cat("==============================\n")

trimester_temperature_correlation <- cor(
  pregnancy_data[
    ,
    c(
      "temperature_first_trimester",
      "temperature_second_trimester",
      "temperature_third_trimester"
    )
  ]
)

print(
  round(
    trimester_temperature_correlation,
    3
  )
)


# ------------------------------------------------------------
# 15. Save descriptive results
# ------------------------------------------------------------

write.csv(
  temperature_by_preeclampsia,
  "04_Results/descriptive_temperature_by_preeclampsia.csv",
  row.names = FALSE
)

write.csv(
  pm25_by_preeclampsia,
  "04_Results/descriptive_pm25_by_preeclampsia.csv",
  row.names = FALSE
)

write.csv(
  birthweight_by_preeclampsia,
  "04_Results/descriptive_birthweight_by_preeclampsia.csv",
  row.names = FALSE
)

write.csv(
  temperature_by_trimester,
  "04_Results/descriptive_temperature_by_trimester.csv",
  row.names = FALSE
)


# ------------------------------------------------------------
# 16. Completion message
# ------------------------------------------------------------

cat("\n==============================\n")
cat("DESCRIPTIVE ANALYSIS COMPLETE\n")
cat("==============================\n")
prop.table(
  table(pregnancy_data$preeclampsia)
) * 100
prop.table(
  table(pregnancy_data$gestational_diabetes)
) * 100
table(pregnancy_data$heat_exposure)
table(pregnancy_data$region)
aggregate(
  mean_temperature_c ~ preeclampsia,
  data = pregnancy_data,
  FUN = mean
)