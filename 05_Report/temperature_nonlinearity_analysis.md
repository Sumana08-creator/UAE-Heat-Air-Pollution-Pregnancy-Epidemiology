# Temperature Non-Linearity Analysis

## Research Question

Does the association between temperature exposure and preeclampsia appear to be non-linear in the synthetic pregnancy cohort?

## Analytical Approach

A linear temperature model was compared with a natural spline model.

Both models adjusted for:

- Mean PM2.5 exposure
- Maternal age
- Pregnancy trimester
- UAE region

The linear model estimated the association between temperature and preeclampsia assuming a constant change in log-odds per 1°C increase.

The natural spline model allowed the temperature association to vary flexibly across the observed temperature range.

The models were compared using a likelihood-ratio test.

## Results

The likelihood-ratio comparison produced:

| Model comparison | Deviance | Degrees of freedom | P-value |
|---|---:|---:|---:|
| Linear vs natural spline temperature model | 0.374 | 2 | 0.830 |

The spline model did not provide a statistically significant improvement in model fit compared with the linear temperature model.

## Interpretation

There was no evidence that the natural spline specification improved model fit compared with the linear temperature specification in this synthetic cohort (likelihood-ratio p = 0.830).

Therefore, the linear temperature specification was retained for the primary analysis.

This suggests that, within this simulated dataset, the association between temperature and preeclampsia can be adequately represented using a linear exposure term.

## Epidemiological Interpretation

Testing for non-linearity is important in environmental epidemiology because exposure-response relationships may not always follow a straight-line pattern.

In a real environmental epidemiology study, non-linear relationships could be investigated using methods such as:

- Natural splines
- Distributed lag non-linear models (DLNMs)
- Flexible exposure-response functions
- Temperature threshold or percentile-based approaches

In this synthetic analysis, the spline comparison did not provide evidence that additional flexibility was required.

## Important Limitation

The temperature exposure in this portfolio is simulated rather than derived from observed environmental monitoring data.

Therefore, the absence of evidence for non-linearity should not be interpreted as evidence that the real-world relationship between temperature and preeclampsia is linear.

The analysis demonstrates the statistical workflow used to evaluate non-linearity rather than providing a real UAE exposure-response estimate.

## Reproducibility

The analysis was performed using R.

The analysis script is:

`02_Code/09_temperature_nonlinearity.R`

The model comparison results are saved in:

`04_Results/temperature_nonlinearity_results.csv`

## Conclusion

The natural spline model did not significantly improve model fit compared with the linear temperature model (p = 0.830).

The linear temperature specification was therefore retained for the primary synthetic analysis.