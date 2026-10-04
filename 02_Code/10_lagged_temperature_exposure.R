# ============================================================
# 10_lagged_temperature_exposure.R
# Synthetic lagged temperature exposure analysis
# ============================================================

# ------------------------------------------------------------
# 1. Load the synthetic pregnancy cohort
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
  pregnancy_data$heat_exposure
)

# ------------------------------------------------------------
# 3. Check the cohort
# ------------------------------------------------------------

dim(pregnancy_data)

head(
  pregnancy_data[
    ,
    c(
      "pregnancy_id",
      "gestational_week",
      "mean_temperature_c",
      "mean_pm25",
      "preeclampsia"
    )
  ]
)

# ------------------------------------------------------------
# 4. Create synthetic temperature exposure windows
# ------------------------------------------------------------

set.seed(2026)

pregnancy_data$temperature_early_pregnancy <- round(
  pregnancy_data$mean_temperature_c +
    rnorm(
      nrow(pregnancy_data),
      mean = 0,
      sd = 1.2
    ),
  1
)

pregnancy_data$temperature_mid_pregnancy <- round(
  pregnancy_data$mean_temperature_c +
    rnorm(
      nrow(pregnancy_data),
      mean = 0,
      sd = 1.2
    ),
  1
)

pregnancy_data$temperature_late_pregnancy <- round(
  pregnancy_data$mean_temperature_c +
    rnorm(
      nrow(pregnancy_data),
      mean = 0,
      sd = 1.2
    ),
  1
)

# ------------------------------------------------------------
# 5. Calculate cumulative temperature exposure
# ------------------------------------------------------------

pregnancy_data$cumulative_temperature_exposure <- round(
  rowMeans(
    pregnancy_data[
      ,
      c(
        "temperature_early_pregnancy",
        "temperature_mid_pregnancy",
        "temperature_late_pregnancy"
      )
    ]
  ),
  2
)

# ------------------------------------------------------------
# 6. Check the new exposure variables
# ------------------------------------------------------------

summary(
  pregnancy_data[
    ,
    c(
      "temperature_early_pregnancy",
      "temperature_mid_pregnancy",
      "temperature_late_pregnancy",
      "cumulative_temperature_exposure"
    )
  ]
)

# ------------------------------------------------------------
# 7. Check correlations between exposure windows
# ------------------------------------------------------------

cor(
  pregnancy_data[
    ,
    c(
      "temperature_early_pregnancy",
      "temperature_mid_pregnancy",
      "temperature_late_pregnancy"
    )
  ]
)

# ------------------------------------------------------------
# 8. Save the expanded exposure dataset
# ------------------------------------------------------------

write.csv(
  pregnancy_data,
  "03_Data/synthetic_pregnancy_cohort_lagged_exposure.csv",
  row.names = FALSE
)

cat(
  "\nLagged temperature exposure dataset saved successfully.\n"
)