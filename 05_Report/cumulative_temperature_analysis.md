# Cumulative Temperature Exposure Analysis

## Research Question

Is cumulative temperature exposure during pregnancy associated with preeclampsia in the synthetic UAE pregnancy cohort?

## Analytical Approach

A cumulative temperature exposure variable was created from three synthetic pregnancy exposure windows:

- Early pregnancy
- Mid pregnancy
- Late pregnancy

The cumulative exposure was calculated as the mean temperature across these three exposure windows.

A multivariable logistic regression model was then fitted to estimate the association between cumulative temperature exposure and preeclampsia.

The model adjusted for:

- Mean PM2.5 exposure
- Maternal age
- Pregnancy trimester
- UAE region

## Statistical Model

The model specification was:

`preeclampsia_binary ~ cumulative_temperature_exposure + mean_pm25 + maternal_age + trimester + region`

The association was expressed as an odds ratio (OR) with a 95% confidence interval (CI).

## Results

The estimated association was:

| Exposure | Odds Ratio | 95% CI | P-value |
|---|---:|---:|---:|
| Cumulative temperature exposure | 1.096 | 1.068–1.125 | <0.001 |

The exact model p-value was:

`8.87 × 10^-12`

## Interpretation

In the synthetic cohort, a 1°C increase in cumulative temperature exposure was associated with approximately 9.6% higher odds of preeclampsia after adjustment for mean PM2.5 exposure, maternal age, pregnancy trimester and region.

The 95% confidence interval was above 1, indicating a positive association in the simulated data.

## Epidemiological Interpretation

Cumulative exposure measures can be useful in environmental epidemiology when researchers are interested in the overall exposure burden across a defined period of pregnancy rather than exposure during a single pregnancy window.

This analysis demonstrates how cumulative environmental exposure can be incorporated into a multivariable epidemiological model.

However, cumulative exposure should not automatically be interpreted as the most biologically relevant exposure metric. Different pregnancy periods may have different susceptibility to environmental exposures, which is why trimester-specific and exposure-window analyses are also included in this portfolio.

## Important Methodological Limitation

The exposure windows in this analysis are simulated from the overall pregnancy temperature variable with random variation.

They are therefore **not genuine longitudinal environmental measurements**.

This analysis should not be described as a true distributed lag model or as evidence of a real UAE temperature–preeclampsia relationship.

A real environmental epidemiology study would ideally link:

- Daily or sub-daily environmental temperature measurements
- Geographic exposure location
- Pregnancy dates
- Gestational age
- Time-specific exposure windows
- Maternal and infant health outcomes

Such data would allow more rigorous investigation of exposure timing and potential lagged effects.

## Relationship to Other Analyses

This cumulative exposure analysis complements the other analyses in the portfolio:

1. Overall temperature and preeclampsia
2. Temperature and PM2.5 adjustment
3. Trimester-specific exposure analysis
4. Temperature × trimester interaction
5. Socioeconomic effect modification
6. Green-space effect modification
7. Non-linear temperature exposure-response assessment
8. Cumulative temperature exposure

Together, these analyses demonstrate a progressively more advanced environmental epidemiology workflow.

## Reproducibility

The analysis was performed using R.

The analysis script is:

`02_Code/11_cumulative_temperature_model.R`

The input dataset is:

`03_Data/synthetic_pregnancy_cohort_lagged_exposure.csv`

The model results are saved in:

`04_Results/cumulative_temperature_preeclampsia_results.csv`

## Data Disclaimer

**This is a synthetic methodological portfolio.**

The pregnancy cohort, environmental exposures and health outcomes are simulated.

The estimated association does not represent a real UAE epidemiological estimate and should not be interpreted as evidence of a causal relationship between temperature exposure and preeclampsia.

The purpose of the analysis is to demonstrate epidemiological study design, statistical modelling, exposure-window analysis and reproducible research practices.

## Conclusion

The cumulative temperature model demonstrated a positive association between cumulative temperature exposure and preeclampsia in the synthetic cohort.

The estimated odds ratio was 1.096 (95% CI 1.068–1.125).

The analysis demonstrates how cumulative environmental exposure can be incorporated into an adjusted epidemiological model while recognising the limitations of simulated exposure data.