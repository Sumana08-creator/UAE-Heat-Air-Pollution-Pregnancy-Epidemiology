# Temperature, Pregnancy Trimester and Preeclampsia

## Research Question

Does the association between temperature exposure and preeclampsia differ according to pregnancy trimester?

## Analytical Approach

A multivariable logistic regression model was used to examine whether pregnancy trimester modified the association between mean temperature and preeclampsia.

The model included:

- mean temperature
- pregnancy trimester
- mean PM2.5 exposure
- maternal age
- region
- the interaction between mean temperature and pregnancy trimester

The interaction model was specified as:

`preeclampsia ~ mean temperature × trimester + PM2.5 + maternal age + region`

The reference category for pregnancy trimester was the first trimester.

Odds ratios were calculated to represent the change in odds of preeclampsia associated with a 1°C increase in temperature within each pregnancy trimester.

## Important Interpretation Principle

Differences between trimester-specific estimates were not interpreted as evidence of effect modification by themselves.

Formal interaction terms were examined to determine whether the temperature–preeclampsia association differed statistically between pregnancy trimesters.

Because this project uses a synthetic dataset, all estimates demonstrate the analytical workflow and should not be interpreted as real-world UAE epidemiological estimates.
## Results

The interaction model estimated the association between a 1°C increase in temperature and preeclampsia separately across pregnancy trimesters.

| Pregnancy trimester | Odds Ratio per 1°C | 95% Confidence Interval |
|---|---:|---:|
| First | 1.121 | 1.060–1.185 |
| Second | 1.111 | 1.064–1.160 |
| Third | 1.048 | 1.002–1.096 |

The estimated association was strongest in the first trimester and weakest in the third trimester.

However, formal interaction testing did not provide strong statistical evidence that the temperature–preeclampsia association differed by trimester. The temperature × second-trimester interaction had a p-value of 0.803, while the temperature × third-trimester interaction had a p-value of 0.064.

Therefore, the results suggest possible attenuation of the temperature association in the third trimester, but do not establish statistically significant effect modification by pregnancy trimester.

## Interpretation

Within this synthetic cohort, higher temperature was positively associated with preeclampsia across all three pregnancy windows.

The estimated odds ratios were:

- 12.1% higher odds per 1°C increase in the first trimester
- 11.1% higher odds per 1°C increase in the second trimester
- 4.8% higher odds per 1°C increase in the third trimester

These estimates should be interpreted together with the formal interaction test. Differences in the magnitude of subgroup estimates alone are not sufficient to conclude that an exposure effect differs between groups.

## Limitation

The temperature exposure used in this synthetic analysis represents an overall pregnancy temperature measure, with trimester-specific variables generated for methodological demonstration.

A real environmental epidemiology study would ideally link time-varying environmental exposures to individual pregnancy timelines and examine exposure windows based on actual gestational dates.

All estimates in this project are simulated and are intended to demonstrate an environmental epidemiology analytical workflow rather than provide real UAE epidemiological estimates.
## Figure

The forest plot below presents the estimated odds ratios and 95% confidence intervals for the association between a 1°C increase in temperature and preeclampsia across pregnancy trimesters.

![Temperature and preeclampsia by pregnancy trimester](../04_Results/temperature_trimester_interaction_forest_plot.png)