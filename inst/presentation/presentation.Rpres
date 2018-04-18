<style>
code {
   background-color: #efefef;
   font-weight: bold;
}
</style>

Reproducible Papers with rrtools
========================================================
author: Charles Lanfear
date: 4/19/2018
width: 1600
height: 900
font-family: helvetica

Before we Begin
========================================================

This presentation will focus on resources for reproducible research, in particular
[Ben Marwick's rrtools](https://github.com/benmarwick/rrtools).

After this presentation, this will be demonstrated using an actual research project in progress: Lanfear, C. and R. Matsueda, "A Dynamic Intrafamily Model of Child Behavior Problems and Birth Timing".

The compendium for this project is available at [github.com/clanfear/birthtiming](http://github.com/clanfear/birthtiming) or can be
installed and loaded as the R package `birthtiming` using the following code:

```
devtools::install_github("clanfear/birthtiming")
library(birthtiming)
```

The current article draft itself may be viewed [here](http://clanfear.github.io/birthtiming/inst/paper/paper.html) or from the link on the project github. The function `birthtiming::open_paper_dir()` will also automaticallly open the directory with the draft on your computer.

These slides are also available at [clanfear.github.io/birthtiming/inst/presentation/presentation.html](http://clanfear.github.io/birthtiming/inst/presentation/presentation.html), and are embedded in the `birthtiming` package.

-

Reproducibility
========================================================
incremental: true

Reproducibility comes in three forms (Stodden 2014):

1. Empirical: Repeatability in data collection.
2. Statistical: Verification with alternate methods of inference.
3. Computational: Reproducible methods of cleaning, organizing, and presention of data and results.

R is particularly well suited to enabling **computational reproducibility**.

-

Computational Reproducibility
========================================================
incremental: true

Elements of computational reproducibility:
* Shared data
* Shared code
* Documentation
* Version Control

R packages are a convenient method of sharing data and code with documentation,
which are easily combined with tools like `git` for version control.

-

Levels of Reproducibility
========================================================
incremental: true

0. "Read the article"
1. Shared data with documentation
2. Shared data and all code
3. Dynamic document
4. **Research compendium**
5. Docker file: Self-contained ecosystem

-

Research Compendia
========================================================
incremental: true

A research compendium is an R package used not to share statistical methods but to organize and share reproducible projects.

Research compendia features:

* Files organized in a recognizable structure (R packages)
* Clear separation of data, method, and output. *Data are read only*.
* A documented or even *preserved* computational environment

`rrtools` provides a simplified workflow to accomplish this.

-

rrtools Benefits
========================================================
incremental: true

`rrtools` compendia facilitate:

*	Convenient public sharing of data and code
*	Increased efficiency due to organization
*	An identical setup for every project to reduce "start-up costs""
*	Integration of tools for collaboration
*	Integration of testing and documentation

You can install `rrtools` directly from GitHub:

```
devtools::install_github("benmarwick/rrtools")
```

-

rrtools Usage
========================================================
incremental: true

The simple `README` on the [`rrtools` github page](https://github.com/benmarwick/rrtools) outlines the one-time function calls used to prepare a compendium for use.

Most important of these:

* `use_compendium("pkgname")` generates a top-level project directory, subfolders, and necessary files.
* `devtools::use_github()` initializes a github repository for the project.
* `rrtools::use_readme_rmd()` generates an RMarkdown file to produce a repository README
* `rrtools::use_analysis()` creates directories and bookdown files for an article

For exact usage, see the link above.

-

rrtools Organization
========================================================
incremental: true

Use of the preceding `rrtools` functions will result in a compendium (R package) with the following structure, familiar to users who have created R packages:

* `README.md` describing the project
* `DESCRIPTION` documenting dependencies and metadata
* `inst/data/` for raw data files
* `inst/analysis/` or `inst/paper/` for scripts, reports, and makefiles
* `R/` for scripts with reusable functions
* `man/` for documentation of functions (`roxygen` suggested)

-

rrtools Workflow
========================================================
incremental: true

Once the compendium has been created, you can

* Place raw data in `inst/data/`
* Write functions in `R/` for processing data or doing analysis
* Write your article or thesis and scripts in `inst/paper/` or `inst/analysis/`
* Produce figures and save them to the `inst/figures/` directory
* Commit changes to github easily (so do it often)

By loading the compendium library at the start of the article `.Rmd` file, all data and functions in the other directories become available.

-

Bookdown
========================================================

If using your compendium to generate an article, thesis, or dissertation, `rrtools` makes formatting simple by integrating `bookdown`.

`bookdown` provides an easily accessible alternative to manually writing LaTeX for typesetting and reference management.

You can integration citations from bibtex files simply by placing the `.bib` file (such as produced by Zotero) in `inst/paper/` then choosing an appropriate citation format in the header of the `paper.Rmd`.

`bookdown` supports `.html` output for ease and speed and also renders `.pdf` files through LaTeX for publication-ready documents.


Overview
========================================================
incremental: true

* `rrtools` provides a relatively simple framework for organizing reproducible projects.

* In general, reproducible frameworks reduce mistakes, improve organization, and protect work.

* There is evidence that reproducible and shared research may be more likely to be cited, and definitely contributes more to the discipline (see Marwick et al. 2017).

* It is *much* easier to start in a reproducible framework than move to one later.

-

References
========================================================

Stodden, V. (2014), "What scientific idea is ready for retirement? Reproducibility." *Edge*. URL: https://www.edge.org/response-detail/25340

Marwick, B., Boettiger, C. & L. Mullen (2017). "Packaging data analytical work reproducibly using R (and friends)." *PeerJ Preprints* 5:e3192v1 https://doi.org/10.7287/peerj.preprints.3192v1

