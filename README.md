
<!-- README.md is generated from README.Rmd. Please edit that file -->
birthtiming
===========

This repository contains the data and code for our paper:

> Lanfear, Charles C. and Ross L. Matsueda, (2018). *A Dynamic Intrafamily Model of Child Behavior Problems and Birth Timing*.

### How to cite

Please cite this compendium as:

> Lanfear, Charles C. and Ross L. Matsueda. (2018). *Compendium of R code and data for 'A Dynamic Intrafamily Model of Child Behavior Problems and Birth Timing'*. Accessed 19 Apr 2018.

### Documents

[To access the paper directly, follow this link.](https://clanfear.github.io/birthtiming/inst/paper/paper.html)

[To access the related presentation, follow this link.](https://clanfear.github.io/birthtiming/inst/presentation/presentation.html)

### How to download or install

You can download the compendium as a zip from from this URL: </archive/master.zip>

Or you can install this compendium as an R package, birthtiming, from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("clanfear/birthtiming")
```

### The R Package

This repository is organized as an R package. There are functions in this package, but they are only intended to be run within the `.Rmd` file that generates the article.

To generate the article from the `birthtiming` library, you may either:

1.  Open and knit the `.Rmd` file found at `birthtiming/paper/paper.Rmd/` in your R libraries.
2.  Clone this github repository and load the `.Rproj` file in RStudio, then knit the paper fron in `inst/paper/paper.Rmd`

In both cases, that directory will already contain a compiled version of the article current to the last commit to this repository.

### Licenses

**Text and figures :** [CC-BY-4.0](http://creativecommons.org/licenses/by/4.0/)

**Code :** See the [DESCRIPTION](DESCRIPTION) file

**Data :** [CC-0](http://creativecommons.org/publicdomain/zero/1.0/) attribution requested in reuse

### Contributions

We welcome contributions from everyone. Before you get started, please see our [contributor guidelines](CONTRIBUTING.md). Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
