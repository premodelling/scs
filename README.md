
<br>

## scs

CHIC601 Group Project: Social Contact Survey

<br>
<br>

### Presentation

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

### Disk Data

* warehouse/geographic.csv

<br>
<br>
<br>
<br>

<br>
<br>
<br>
<br>