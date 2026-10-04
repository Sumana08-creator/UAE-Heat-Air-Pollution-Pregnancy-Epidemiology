# ============================================================
# 08_socioeconomic_green_space_effect_modification.R
# Synthetic socioeconomic and green-space effect modification
# ============================================================

# Load data
pregnancy_data <- read.csv(
  "03_Data/synthetic_pregnancy_cohort.csv"
)

# ------------------------------------------------------------
# Generate synthetic contextual variables
# ------------------------------------------------------------

set.seed(2026)

n <- nrow(pregnancy_data)

# Synthetic socioeconomic index
pregnancy_data$socioeconomic_index <- round(
  rnorm(n, mean = 0, sd = 1),
  2
)

# Synthetic green-space access
green_space_probability <- plogis(
  0.4 +
    0.5 * pregnancy_data$socioeconomic_index
)

pregnancy_data$green_space_access <- ifelse(
  runif(n) < green_space_probability,
  "Higher",
  "Lower"
)

# Convert to factor
pregnancy_data$green_space_access <- factor(
  pregnancy_data$green_space_access,
  levels = c("Lower", "Higher")
)

# ------------------------------------------------------------
# Basic checks
# ------------------------------------------------------------

summary(pregnancy_data$socioeconomic_index)

table(pregnancy_data$green_space_access)

# ------------------------------------------------------------
# Save updated synthetic dataset
# ------------------------------------------------------------

write.csv(
  pregnancy_data,
  "03_Data/synthetic_pregnancy_cohort_with_contextual_variables.csv",
  row.names = FALSE
)

cat(
  "\nSynthetic socioeconomic and green-space variables generated successfully.\n"
)
# ------------------------------------------------------------
# Socioeconomic status as an effect modifier
# ------------------------------------------------------------

# Convert variables needed for modelling
pregnancy_data$region <- factor(
  pregnancy_data$region
)

pregnancy_data$trimester <- factor(
  pregnancy_data$trimester,
  levels = c("First", "Second", "Third")
)

# Main-effects model
socioeconomic_main_model <- glm(
  preeclampsia_binary ~
    mean_temperature_c +
    socioeconomic_index +
    mean_pm25 +
    maternal_age +
    trimester +
    region,
  data = pregnancy_data,
  family = binomial
)

# Interaction model
socioeconomic_interaction_model <- glm(
  preeclampsia_binary ~
    mean_temperature_c * socioeconomic_index +
    mean_pm25 +
    maternal_age +
    trimester +
    region,
  data = pregnancy_data,
  family = binomial
)

# Display interaction model
summary(socioeconomic_interaction_model)

# Formal likelihood-ratio test
anova(
  socioeconomic_main_model,
  socioeconomic_interaction_model,
  test = "Chisq"
)
# ------------------------------------------------------------
# Green-space access as an effect modifier
# ------------------------------------------------------------

# Main-effects model
green_space_main_model <- glm(
  preeclampsia_binary ~
    mean_temperature_c +
    green_space_access +
    mean_pm25 +
    maternal_age +
    trimester +
    region,
  data = pregnancy_data,
  family = binomial
)

# Interaction model
green_space_interaction_model <- glm(
  preeclampsia_binary ~
    mean_temperature_c * green_space_access +
    mean_pm25 +
    maternal_age +
    trimester +
    region,
  data = pregnancy_data,
  family = binomial
)

# Display interaction model
summary(green_space_interaction_model)

# Formal likelihood-ratio test
anova(
  green_space_main_model,
  green_space_interaction_model,
  test = "Chisq"
)
# ------------------------------------------------------------
# Save effect-modification results
# ------------------------------------------------------------

socioeconomic_test <- anova(
  socioeconomic_main_model,
  socioeconomic_interaction_model,
  test = "Chisq"
)

green_space_test <- anova(
  green_space_main_model,
  green_space_interaction_model,
  test = "Chisq"
)

effect_modification_results <- data.frame(
  Effect_Modifier = c(
    "Socioeconomic index",
    "Green-space access"
  ),
  Interaction_Test = c(
    "Temperature × socioeconomic index",
    "Temperature × green-space access"
  ),
  Deviance = c(
    socioeconomic_test$Deviance[2],
    green_space_test$Deviance[2]
  ),
  P_Value = c(
    socioeconomic_test$`Pr(>Chi)`[2],
    green_space_test$`Pr(>Chi)`[2]
  )
)

print(effect_modification_results)

write.csv(
  effect_modification_results,
  "04_Results/effect_modification_results.csv",
  row.names = FALSE
)

cat(
  "\nEffect-modification results saved successfully.\n"
)