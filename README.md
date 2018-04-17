
Statistics Netherlands (www.cbs.nl) opendata API client for R
=============================================================

[![version](http://www.r-pkg.org/badges/version/cbsodataR)](https://CRAN.R-project.org/package=cbsodataR) ![downloads](http://cranlogs.r-pkg.org/badges/cbsodataR) [![Travis-CI Build Status](https://travis-ci.org/edwindj/cbsodataR.png?branch=master)](https://travis-ci.org/edwindj/cbsodataR) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/edwindj/cbsodatar?branch=master)](https://ci.appveyor.com/project/edwindj/cbsodatar)

Retrieve data from the [open data interface](http://www.cbs.nl/nl-NL/menu/cijfers/statline/open-data/default.htm) (dutch) of Statistics Netherlands (cbs.nl) with *R*.

Python user? Use [cbsodata](https://github.com/J535D165/cbsodata).

API change (0.3+)
-----------------

**In version 0.3 the api of the functions has changed. Old functions (should) still work, but generate warnings asking to switch to the new api.**

Installation
============

From CRAN

``` s
install.packages("cbsodataR")
```

The latest development version of `cbsodata` can installed using `devtools`.

``` r
devtools::install_github("edwindj/cbsodataR")
```

Usage (version 0.3+)
====================

Retrieve list a tables.

``` r
library(cbsodataR)
toc <- cbs_get_toc("Language" = "en")
head(toc)
```

    ## # A tibble: 6 x 25
    ##   Updated  Identifier Title ShortTitle ShortDescription   Summary Modified
    ##   <chr>    <chr>      <chr> <chr>      <chr>              <chr>   <chr>   
    ## 1 2018-03… 80783eng   Agri… Agricultu… "\nThis table con… "Agric… 2018-03…
    ## 2 2018-02… 80784eng   Agri… Agricultu… "\nThis table con… "Agric… 2018-02…
    ## 3 2018-02… 7100eng    Arab… Arable cr… "\nThis table pro… "Area … 2018-02…
    ## 4 2017-03… 70671ENG   Frui… Fruit cul… "\nThis table pro… "Culti… 2017-03…
    ## 5 2018-03… 37738ENG   Vege… Vegetable… "\nThis table pro… "Area … 2018-03…
    ## 6 2018-03… 71509ENG   Yiel… Yield app… "\nThis table pro… "yield… 2018-03…
    ## # ... with 18 more variables: MetaDataModified <chr>,
    ## #   ReasonDelivery <chr>, ExplanatoryText <chr>, OutputStatus <chr>,
    ## #   Source <chr>, Language <chr>, Catalog <chr>, Frequency <chr>,
    ## #   Period <chr>, SummaryAndLinks <chr>, ApiUrl <chr>, FeedUrl <chr>,
    ## #   DefaultPresentation <chr>, DefaultSelection <chr>, GraphTypes <chr>,
    ## #   RecordCount <int>, ColumnCount <int>, SearchPriority <chr>

Use the `Identifier` from tables to retrieve table information

``` r
cbs_get_meta('71509ENG')
```

    ## 71509ENG: 'Yield apples and pears', 2017
    ##   FruitFarmingRegions: 'Fruit farming regions'
    ##   Periods: 'Periods'

Or download data.

``` r
library(dplyr) # just for example's sake
apples <- cbs_get_data("71509ENG") 

apples %>% 
  select(1:4)
```

    ## # A tibble: 105 x 4
    ##    FruitFarmingRegions Periods  TotalAppleVarieties_1 CoxSOrangePippin_2
    ##                  <int> <fct>                    <int>              <int>
    ##  1                   1 1997JJ00                   420                 43
    ##  2                   1 1998JJ00                   518                 40
    ##  3                   1 1999JJ00                   568                 39
    ##  4                   1 2000JJ00                   461                 27
    ##  5                   1 2001JJ00                   408                 30
    ##  6                   1 2002JJ00                   354                 17
    ##  7                   1 2003JJ00                   359                 17
    ##  8                   1 2004JJ00                   436                 14
    ##  9                   1 2005JJ00                   359                 12
    ## 10                   1 2006JJ00                   365                 11
    ## # ... with 95 more rows

add label columns:

``` r
apples %>% 
  cbs_add_label_columns() %>% 
  select(1:4)
```

    ## # A tibble: 105 x 4
    ##    FruitFarmingRegions FruitFarmingRegions_label Periods  Periods_label
    ##                  <int> <fct>                     <fct>    <fct>        
    ##  1                   1 Total Netherlands         1997JJ00 1997         
    ##  2                   1 Total Netherlands         1998JJ00 1998         
    ##  3                   1 Total Netherlands         1999JJ00 1999         
    ##  4                   1 Total Netherlands         2000JJ00 2000         
    ##  5                   1 Total Netherlands         2001JJ00 2001         
    ##  6                   1 Total Netherlands         2002JJ00 2002         
    ##  7                   1 Total Netherlands         2003JJ00 2003         
    ##  8                   1 Total Netherlands         2004JJ00 2004         
    ##  9                   1 Total Netherlands         2005JJ00 2005         
    ## 10                   1 Total Netherlands         2006JJ00 2006         
    ## # ... with 95 more rows

For more information, see \`vignette("")
