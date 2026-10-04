# Effect Modification by Socioeconomic Conditions and Green-Space Access

## Research Question

This analysis examined whether the association between temperature exposure and preeclampsia differed according to socioeconomic conditions and access to green space.

These potential effect modifiers were selected because environmental health risks may not be distributed equally across population groups or living environments.

## Analytical Approach

Effect modification was assessed using multiplicative interaction terms in multivariable logistic regression models.

The primary outcome was preeclampsia.

The models adjusted for:

- Mean PM2.5 exposure
- Maternal age
- Pregnancy trimester
- Region

Two potential effect modifiers were evaluated:

1. Socioeconomic index
2. Green-space access

For each potential effect modifier, a model containing the main effects was compared with a model containing the temperature × effect-modifier interaction.

Likelihood-ratio tests were used to assess whether adding the interaction term significantly improved model fit.

## Socioeconomic Effect Modification

The temperature × socioeconomic index interaction was not statistically significant.

| Effect modifier | Deviance | p-value |
|---|---:|---:|
| Socioeconomic index | 1.7462 | 0.1864 |

The likelihood-ratio test provided no strong evidence that the temperature–preeclampsia association differed according to socioeconomic conditions in the synthetic cohort.

## Green-Space Effect Modification

The temperature × green-space access interaction was also not statistically significant.

| Effect modifier | Deviance | p-value |
|---|---:|---:|
| Green-space access | 1.4103 | 0.2350 |

The likelihood-ratio test provided no strong evidence that the temperature–preeclampsia association differed according to green-space access in the synthetic cohort.

## Interpretation

Neither potential effect modifier significantly improved model fit:

- Temperature × socioeconomic index: p = 0.186
- Temperature × green-space access: p = 0.235

Therefore, the synthetic analyses did not provide strong statistical evidence that the temperature–preeclampsia association varied according to socioeconomic conditions or green-space access.

Importantly, absence of statistical evidence for interaction should not be interpreted as proof that no effect modification exists.

## Methodological Interpretation

The analysis demonstrates how contextual characteristics can be evaluated as potential effect modifiers in environmental epidemiology.

The workflow was:

1. Define the environmental exposure.
2. Define the health outcome.
3. Identify a potential contextual effect modifier.
4. Fit a model containing the main effects.
5. Add the exposure × modifier interaction.
6. Compare model fit using a likelihood-ratio test.
7. Interpret the interaction without assuming that modification must be present.

## Important Data Limitation

The socioeconomic index and green-space access variables were synthetically generated for methodological demonstration.

They do not represent measured socioeconomic conditions or actual green-space exposure among UAE residents.

Consequently, these analyses demonstrate the statistical workflow for assessing effect modification rather than providing evidence about environmental inequalities or green-space-related differences in real UAE pregnancy populations.

## Reproducibility

The analysis was implemented in R using the script:

`02_Code/08_socioeconomic_green_space_effect_modification.R`

The resulting interaction-test statistics were saved to:

`04_Results/effect_modification_results.csv`

All analyses use synthetic data and are intended to demonstrate a reproducible environmental epidemiology workflow.