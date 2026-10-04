# ============================================================
# 07_temperature_trimester_interaction.R
# Temperature, Trimester and Preeclampsia Interaction
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

# Check outcome
table(pregnancy_data$preeclampsia_binary)

# ------------------------------------------------------------
# Interaction model
# ------------------------------------------------------------

interaction_model <- glm(
  preeclampsia_binary ~
    mean_temperature_c * trimester +
    mean_pm25 +
    maternal_age +
    region,
  data = pregnancy_data,
  family = binomial
)

# Display model
summary(interaction_model)

# ------------------------------------------------------------
# Save model coefficients
# ------------------------------------------------------------

interaction_results <- data.frame(
  Term = names(coef(interaction_model)),
  Estimate = coef(interaction_model),
  Odds_Ratio = exp(coef(interaction_model)),
  P_Value = summary(interaction_model)$coefficients[, 4]
)

print(interaction_results)

write.csv(
  interaction_results,
  "04_Results/temperature_trimester_interaction.csv",
  row.names = FALSE
)

cat("\nTemperature-trimester interaction analysis completed successfully.\n")
# ------------------------------------------------------------
# Temperature effect within each trimester
# ------------------------------------------------------------

beta_temperature <- coef(interaction_model)["mean_temperature_c"]

beta_second <- coef(interaction_model)[
  "mean_temperature_c:trimesterSecond"
]

beta_third <- coef(interaction_model)[
  "mean_temperature_c:trimesterThird"
]

trimester_temperature_OR <- data.frame(
  Trimester = c("First", "Second", "Third"),
  OR_per_1C = c(
    exp(beta_temperature),
    exp(beta_temperature + beta_second),
    exp(beta_temperature + beta_third)
  )
)

print(trimester_temperature_OR)

write.csv(
  trimester_temperature_OR,
  "04_Results/trimester_temperature_OR_from_interaction.csv",
  row.names = FALSE
)
# ------------------------------------------------------------
# Confidence intervals for trimester-specific temperature ORs
# ------------------------------------------------------------

vcov_matrix <- vcov(interaction_model)

beta_first <- beta_temperature
beta_second_total <- beta_temperature + beta_second
beta_third_total <- beta_temperature + beta_third

se_first <- sqrt(
  vcov_matrix["mean_temperature_c",
              "mean_temperature_c"]
)

se_second <- sqrt(
  vcov_matrix["mean_temperature_c",
              "mean_temperature_c"] +
    vcov_matrix["mean_temperature_c:trimesterSecond",
                "mean_temperature_c:trimesterSecond"] +
    2 * vcov_matrix["mean_temperature_c",
                    "mean_temperature_c:trimesterSecond"]
)

se_third <- sqrt(
  vcov_matrix["mean_temperature_c",
              "mean_temperature_c"] +
    vcov_matrix["mean_temperature_c:trimesterThird",
                "mean_temperature_c:trimesterThird"] +
    2 * vcov_matrix["mean_temperature_c",
                    "mean_temperature_c:trimesterThird"]
)

trimester_interaction_results <- data.frame(
  Trimester = c("First", "Second", "Third"),
  
  OR_per_1C = c(
    exp(beta_first),
    exp(beta_second_total),
    exp(beta_third_total)
  ),
  
  CI_Lower = c(
    exp(beta_first - 1.96 * se_first),
    exp(beta_second_total - 1.96 * se_second),
    exp(beta_third_total - 1.96 * se_third)
  ),
  
  CI_Upper = c(
    exp(beta_first + 1.96 * se_first),
    exp(beta_second_total + 1.96 * se_second),
    exp(beta_third_total + 1.96 * se_third)
  )
)

print(trimester_interaction_results)

write.csv(
  trimester_interaction_results,
  "04_Results/trimester_temperature_OR_with_CI.csv",
  row.names = FALSE
)
trimester_interaction_results
# ------------------------------------------------------------
# Forest plot: temperature effect by pregnancy trimester
# ------------------------------------------------------------

library(ggplot2)

forest_plot <- ggplot(
  trimester_interaction_results,
  aes(x = OR_per_1C, y = Trimester)
) +
  geom_point(size = 3) +
  geom_errorbarh(
    aes(xmin = CI_Lower, xmax = CI_Upper),
    height = 0.2
  ) +
  geom_vline(
    xintercept = 1,
    linetype = "dashed"
  ) +
  labs(
    title = "Temperature and Preeclampsia by Pregnancy Trimester",
    subtitle = "Odds ratio per 1°C increase in temperature",
    x = "Odds Ratio (95% CI)",
    y = "Pregnancy trimester"
  ) +
  theme_minimal()

print(forest_plot)

ggsave(
  "04_Results/temperature_trimester_interaction_forest_plot.png",
  plot = forest_plot,
  width = 8,
  height = 5,
  dpi = 300
)