# Statistics Netherlands (www.cbs.nl) opendata API client for R

**the url of the CBS Open Data api will change from "http" to "https"**

**`cbsodataR` version 2.4 and later will use `https` by default.**

[![version](http://www.r-pkg.org/badges/version/cbsodataR)](https://CRAN.R-project.org/package=cbsodataR)
![downloads](http://cranlogs.r-pkg.org/badges/cbsodataR)
[![Travis-CI Build Status](https://travis-ci.org/edwindj/cbsodataR.png?branch=master)](https://travis-ci.org/edwindj/cbsodataR)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/edwindj/cbsodatar?branch=master)](https://ci.appveyor.com/project/edwindj/cbsodatar)

Retrieve data from the [open data interface](http://www.cbs.nl/nl-NL/menu/cijfers/statline/open-data/default.htm) (dutch) of Statistics Netherlands (cbs.nl) with *R*. 

Python user?  Use [cbsodata](https://github.com/J535D165/cbsodata).

# Installation

From CRAN
```S
install.packages("cbsodataR")
``` 

The latest development version of `cbsodata` can installed using `devtools`.

```R
devtools::install_github("edwindj/cbsodataR")
```

# Usage

Retrieve list a tables.
```R
> tables <- get_table_list(Language="en")
```

Use the `Identifier` from tables to retrieve table information

```R
> get_meta('71509ENG')

71509ENG: 'Yield apples and pears', 2013
  FruitFarmingRegions: 'Fruit farming regions'
  Periods: 'Periods' 
```

Or download data

```
> library(dplyr) # to help select data and use the %>% operator
> get_data('71509ENG') %>% select(2:5) %>% head

Source: local data frame [6 x 4]

  FruitFarmingRegions Periods TotalAppleVarieties_1 CoxSOrangePippin_2
1   Total Netherlands    1997                   420                 43
2   Total Netherlands    1998                   518                 40
3   Total Netherlands    1999                   568                 39
4   Total Netherlands    2000                   461                 27
5   Total Netherlands    2001                   408                 30
6   Total Netherlands    2002                   354                 17

```
