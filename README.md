
* [functions directory](R/functions)
* [the data preparation function](R/functions/SurveyData.R)
* [a pdf with basic exploration outputs](exploration.pdf)
* [a script file for exploring/playing](R/exploration.R)

<br>
<br>

## scs

CHIC601 Group Project: Social Contact Survey

<br>
<br>

### Presentation

A plan?

* Exploratory Data Analysis:
  * data preparation
  * relationships between variables
  * data representativeness  

* Hypothesis:<br>
  &nbsp; &nbsp; Postulate a hypothesis based on the exploration's observations, insights, and/or questions

* Investigation of Hypothesis:<br>
  &nbsp; &nbsp; Via appropriate statistical modelling & analysis methods

* Summary & Discussion of Results

* Limitations & Bias: w.r.t
  * data collected
  * hypothesis investigation    

<br>
<br>

### Discussion

Subject to:

* Using a representative sample of respondents based on population age-group & sex; additionally constrained 
  by an *age-group intersection sex* cut-off due to survey data limitations.

* A modelling approach that adjusts for all other variables.

Possible hypothesis:

1. total contacts is significantly dependent on occupation

2. total contacts is significantly dependent on age group

3. [or the intersection of 1 & 2]

<br>
<br>

### Notes

* The distinct elements of ``unmatched_postcode`` are `-1, 0, 1` not `0, 1`.

<br>
<br>

### Modelling & Analysis Snippets

For arranging the ``agegroup`` field

```r
labelling <- FrequenciesTable(field = survey$agegroup, fieldname = 'agegroup') %>%
    arrange(-frequency) %>%
    filter(!is.na(agegroup))

factor(x = survey$agegroup, levels = unlist(labelling$agegroup))
```

<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>