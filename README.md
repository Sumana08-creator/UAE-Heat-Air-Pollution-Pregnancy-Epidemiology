# UAE Heat, Air Pollution and Pregnancy Epidemiology

## A Synthetic Environmental Epidemiology Portfolio

![R](https://img.shields.io/badge/R-4.6.1-blue)
![Research](https://img.shields.io/badge/Project-Environmental%20Epidemiology-green)
![Data](https://img.shields.io/badge/Data-Synthetic-orange)
![Status](https://img.shields.io/badge/Status-Completed-success)

---

## Overview

This project is a synthetic environmental epidemiology portfolio investigating how heat and ambient air-pollution exposures during pregnancy may be associated with maternal complications and early-life growth.

The project uses a simulated UAE pregnancy cohort to demonstrate a reproducible epidemiological workflow relevant to environmental health, pregnancy research and exposure epidemiology.

The project was developed in **R** and includes data generation, quality checking, descriptive epidemiology, regression modelling, exposure-window analysis, interaction analysis, effect modification, non-linearity assessment and sensitivity analysis.

---

## Research Question

> **How are extreme heat and ambient air-pollution exposures during pregnancy associated with maternal complications and early-life growth in a synthetic UAE pregnancy cohort, and do these associations vary by pregnancy stage, socioeconomic conditions and access to green space?**

---

## Important Data Disclaimer

**This is a synthetic methodological portfolio.**

The pregnancy cohort, health outcomes and environmental exposure variables are simulated for analytical demonstration.

The data do **not** represent:

- a real UAE pregnancy registry
- real patient records
- real UAE environmental monitoring data
- real clinical estimates

Therefore, the findings should **not** be interpreted as evidence of causal relationships or as estimates of the health effects of heat or air pollution in the UAE.

The purpose of this project is to demonstrate:

- epidemiological study design
- reproducible statistical programming
- environmental exposure analysis
- pregnancy exposure-window analysis
- multivariable regression
- interaction modelling
- effect modification
- non-linear exposure-response assessment
- sensitivity analysis
- scientific interpretation
- transparent research reporting

---

# Research Design

## Synthetic Study Population

The project contains:

**10,000 simulated pregnancies**

Simulated variables include:

- maternal age
- gestational week
- geographic region
- pregnancy trimester
- temperature exposure
- PM2.5 exposure
- preeclampsia
- gestational diabetes
- birthweight

Simulated regions:

- Dubai
- Abu Dhabi
- Sharjah

---

## Environmental Exposures

### Temperature

Mean pregnancy temperature was used as the primary temperature exposure.

A high-heat category was additionally created using a simulated threshold of:

**≥35°C**

### PM2.5

Ambient PM2.5 concentration was included as a simulated air-pollution exposure.

### Pregnancy Exposure Windows

Additional synthetic exposure variables were generated for:

- early pregnancy
- mid pregnancy
- late pregnancy
- cumulative pregnancy exposure

These variables demonstrate exposure-window methodology but are **not genuine longitudinal environmental measurements**.

---

# Outcomes

## Primary Outcome

**Preeclampsia**

## Secondary Outcomes

**Gestational diabetes**

**Birthweight**

Preeclampsia and gestational diabetes were modelled as binary outcomes.

Birthweight was analysed as a continuous outcome measured in grams.

---

# Analytical Workflow

The project includes the following analyses:

1. Synthetic pregnancy cohort generation
2. Data quality and consistency checks
3. Descriptive epidemiology
4. Multivariable logistic regression for preeclampsia
5. Multivariable logistic regression for gestational diabetes
6. Multivariable linear regression for birthweight
7. Pregnancy-trimester exposure-window analysis
8. Temperature × trimester interaction modelling
9. Socioeconomic effect modification
10. Green-space effect modification
11. Temperature non-linearity assessment
12. Cumulative temperature exposure analysis
13. Sensitivity analysis using alternative exposure definitions
14. Final epidemiological results summary
15. Reproducible research reporting

---

# Key Synthetic Findings

### Temperature and preeclampsia

In the fully adjusted synthetic model:

**OR 1.090, 95% CI 1.061–1.120**

for each 1°C increase in mean temperature.

The model adjusted for:

- PM2.5
- maternal age
- trimester
- region

### PM2.5 and preeclampsia

**OR 1.020, 95% CI 1.010–1.031**

per one-unit increase in simulated PM2.5.

### Temperature and gestational diabetes

**OR 1.059, 95% CI 1.036–1.083**

per 1°C increase in mean temperature.

### Temperature and birthweight

**β = −34.91 g, 95% CI −37.85 to −31.97**

per 1°C increase in mean temperature.

### Pregnancy exposure windows

Positive temperature-preeclampsia associations were observed across all three simulated pregnancy trimesters.

However, the formal temperature × trimester interaction analysis did **not** provide strong statistical evidence that the association differed between pregnancy stages.

### Effect modification

There was no strong evidence of effect modification by:

- socioeconomic index: **p = 0.186**
- green-space access: **p = 0.235**

### Non-linearity

A natural spline model did not significantly improve model fit compared with the linear temperature model:

**Likelihood-ratio p = 0.829**

### Cumulative exposure

Cumulative temperature exposure showed:

**OR 1.096, 95% CI 1.068–1.125**

per 1°C increase.

### Sensitivity analysis

The direction of association was consistent across alternative temperature exposure definitions:

| Exposure definition | Odds Ratio | 95% CI |
|---|---:|---:|
| Overall mean temperature | 1.090 | 1.061–1.120 |
| Cumulative temperature | 1.096 | 1.068–1.125 |
| High vs lower heat | 1.606 | 1.323–1.939 |

Again, these are **simulated results** and should not be interpreted as real UAE epidemiological estimates.

---

# Pregnancy Exposure-Window Analysis

Temperature associations were estimated separately across pregnancy:

| Pregnancy window | OR per 1°C | 95% CI |
|---|---:|---:|
| First trimester | 1.082 | 1.056–1.109 |
| Second trimester | 1.082 | 1.056–1.108 |
| Third trimester | 1.070 | 1.045–1.096 |

A formal interaction analysis produced:

| Interaction | P value |
|---|---:|
| Temperature × second trimester | 0.803 |
| Temperature × third trimester | 0.064 |

The results demonstrate how pregnancy-stage exposure windows can be investigated, while avoiding an unsupported claim of a specific critical window.

---

# Visualisation

## Temperature and Preeclampsia by Pregnancy Trimester

![Temperature and preeclampsia by pregnancy trimester](04_Results/temperature_trimester_interaction_forest_plot.png)

## Temperature and Preeclampsia Exposure Analysis

![Temperature and preeclampsia exposure analysis](04_Results/temperature_preeclampsia_forest_plot.png)

---

# Methodological Considerations

## Non-linearity

Temperature non-linearity was assessed using a natural spline specification.

The spline model did not significantly improve fit compared with the linear model.

However, this finding reflects the synthetic data-generating process and should not be interpreted as evidence that real-world temperature-health relationships are linear.

## Effect Modification

Interaction models were used to investigate whether the temperature-preeclampsia association varied according to socioeconomic conditions and green-space access.

The contextual variables were synthetically generated and therefore cannot represent real-world environmental inequalities.

## Cumulative Exposure

Cumulative temperature exposure was created by averaging synthetic early-, mid- and late-pregnancy temperature measurements.

This demonstrates an exposure-window approach.

**It is not a true distributed lag non-linear model (DLNM).**

A genuine DLNM would require time-varying environmental exposure data linked to pregnancy dates and an appropriate temporal outcome structure.

---

# Limitations

The most important limitation is that the entire dataset is synthetic.

Specific limitations include:

- environmental exposures are simulated
- pregnancy outcomes are simulated
- exposure windows are simulated
- socioeconomic variables are simulated
- green-space access is simulated
- no real clinical registry was used
- no real UAE environmental monitoring data were used
- no causal inference should be drawn

A real environmental epidemiology study could incorporate:

- daily temperature measurements
- daily PM2.5 measurements
- geocoded residential exposure
- pregnancy start and delivery dates
- individual exposure windows
- socioeconomic indicators
- green-space measurements
- clinical registry outcomes
- potential confounders
- co-exposures
- meteorological variables

---

# Reproducibility

The project is organised into separate directories for protocol, code, data, results and reporting.

```text
UAE-Heat-Air-Pollution-Pregnancy-Epidemiology/
│
├── 01_Project_Protocol/
│
├── 02_Code/
│   ├── 01_generate_cohort.R
│   ├── 02_descriptive_analysis.R
│   ├── 03_preeclampsia_models.R
│   ├── 04_trimester_specific_models.R
│   ├── 05_gdm_model.R
│   ├── 06_birthweight_model.R
│   ├── 07_temperature_trimester_interaction.R
│   ├── 08_socioeconomic_green_space_effect_modification.R
│   ├── 09_temperature_nonlinearity.R
│   ├── 10_lagged_temperature_exposure.R
│   ├── 11_cumulative_temperature_model.R
│   ├── 12_sensitivity_analysis.R
│   └── 13_final_results_summary.R
│
├── 03_Data/
│
├── 04_Results/
│
└── 05_Report/