# ============================================================
# UAE Heat, Air Pollution and Pregnancy Epidemiology
# Step 4: Trimester-Specific Temperature Models
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


# ------------------------------------------------------------
# MODEL 1: FIRST-TRIMESTER TEMPERATURE
# ------------------------------------------------------------

model_first <- glm(
  preeclampsia_binary ~
    temperature_first_trimester +
    mean_pm25 +
    maternal_age +
    region,
  data = pregnancy_data,
  family = binomial
)


# ------------------------------------------------------------
# MODEL 2: SECOND-TRIMESTER TEMPERATURE
# ------------------------------------------------------------

model_second <- glm(
  preeclampsia_binary ~
    temperature_second_trimester +
    mean_pm25 +
    maternal_age +
    region,
  data = pregnancy_data,
  family = binomial
)


# ------------------------------------------------------------
# MODEL 3: THIRD-TRIMESTER TEMPERATURE
# ------------------------------------------------------------

model_third <- glm(
  preeclampsia_binary ~
    temperature_third_trimester +
    mean_pm25 +
    maternal_age +
    region,
  data = pregnancy_data,
  family = binomial
)


# ------------------------------------------------------------
# 3. Extract odds ratios and 95% confidence intervals
# ------------------------------------------------------------

extract_temperature_result <- function(
    model,
    exposure,
    window,
    model_name
) {
  
  coefficient <- summary(model)$coefficients[
    exposure,
    "Estimate"
  ]
  
  standard_error <- summary(model)$coefficients[
    exposure,
    "Std. Error"
  ]
  
  p_value <- summary(model)$coefficients[
    exposure,
    "Pr(>|z|)"
  ]
  
  data.frame(
    Exposure_Window = window,
    Exposure_Variable = exposure,
    OR_per_1C = exp(coefficient),
    CI_Lower = exp(
      coefficient - 1.96 * standard_error
    ),
    CI_Upper = exp(
      coefficient + 1.96 * standard_error
    ),
    P_Value = p_value,
    AIC = AIC(model),
    Model = model_name
  )
}


# ------------------------------------------------------------
# 4. Create the trimester results table
# ------------------------------------------------------------

trimester_results <- rbind(
  
  extract_temperature_result(
    model_first,
    "temperature_first_trimester",
    "First trimester",
    "First-trimester model"
  ),
  
  extract_temperature_result(
    model_second,
    "temperature_second_trimester",
    "Second trimester",
    "Second-trimester model"
  ),
  
  extract_temperature_result(
    model_third,
    "temperature_third_trimester",
    "Third trimester",
    "Third-trimester model"
  )
)


# ------------------------------------------------------------
# 5. Display results
# ------------------------------------------------------------

print(
  trimester_results
)


# ------------------------------------------------------------
# 6. Save results
# ------------------------------------------------------------

write.csv(
  trimester_results,
  "04_Results/trimester_specific_results.csv",
  row.names = FALSE
)


# ------------------------------------------------------------
# 7. Completion message
# ------------------------------------------------------------

cat("\n==============================\n")
cat("TRIMESTER-SPECIFIC ANALYSIS COMPLETE\n")
cat("==============================\n")
trimester_results
# ------------------------------------------------------------
# 8. Create forest plot
# ------------------------------------------------------------

library(ggplot2)

forest_plot <- ggplot(
  trimester_results,
  aes(
    x = OR_per_1C,
    y = Exposure_Window
  )
) +
  geom_point(size = 3) +
  geom_errorbarh(
    aes(
      xmin = CI_Lower,
      xmax = CI_Upper
    ),
    height = 0.2
  ) +
  geom_vline(
    xintercept = 1,
    linetype = "dashed"
  ) +
  labs(
    title = "Temperature Exposure and Preeclampsia by Pregnancy Window",
    x = "Odds Ratio per 1°C increase",
    y = "Pregnancy exposure window"
  ) +
  theme_minimal()

print(forest_plot)


# ------------------------------------------------------------
# 9. Save forest plot
# ------------------------------------------------------------

ggsave(
  "04_Results/temperature_preeclampsia_forest_plot.png",
  plot = forest_plot,
  width = 8,
  height = 5,
  dpi = 300
)