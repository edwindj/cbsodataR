
# Statistics Netherlands (www.cbs.nl) opendata API client for R

[![version](http://www.r-pkg.org/badges/version/cbsodataR)](https://CRAN.R-project.org/package=cbsodataR)
![downloads](http://cranlogs.r-pkg.org/badges/cbsodataR) [![R build
status](https://github.com/edwindj/cbsodataR/workflows/R-CMD-check/badge.svg)](https://github.com/edwindj/cbsodataR/actions)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/edwindj/cbsodatar?branch=master)](https://ci.appveyor.com/project/edwindj/cbsodatar)

Retrieve data and spatial maps from the [open data
interface](http://www.cbs.nl/nl-NL/menu/cijfers/statline/open-data/default.htm)
(dutch) of Statistics Netherlands (cbs.nl) with *R*.

# Installation

From CRAN

``` s
install.packages("cbsodataR")
```

The latest development version of `cbsodata` can installed using
`devtools`.

``` r
devtools::install_github("edwindj/cbsodataR")
```

# Usage

Retrieve a table of contents with all SN tables.

``` r
library(cbsodataR)
ds <- cbs_get_datasets("Language" = "en")
head(ds)
```

    ## # A tibble: 6 × 25
    ##   Updated             Identifier Title       ShortTitle ShortDescription Summary
    ##   <dttm>              <chr>      <chr>       <chr>      <chr>            <chr>  
    ## 1 2023-11-30 00:00:00 80783eng   Agricultur… Agricultu… "\nThis table c… "Agric…
    ## 2 2023-11-30 00:00:00 80784eng   Agricultur… Agricultu… "\nThis table c… "Agric…
    ## 3 2023-12-12 00:00:00 85636ENG   Arable cro… Arable cr… "\nThis table p… "area …
    ## 4 2023-04-03 00:00:00 37738ENG   Vegetables… Vegetable… "\nThis table p… "Area …
    ## 5 2023-06-30 00:00:00 83981ENG   Livestock … Livestock… "\nThis table c… "Manur…
    ## 6 2023-10-12 00:00:00 84952ENG   Livestock … Livestock  "\nThis table c… "Lives…
    ## # ℹ 19 more variables: Modified <dttm>, MetaDataModified <dttm>,
    ## #   ReasonDelivery <chr>, ExplanatoryText <chr>, OutputStatus <chr>,
    ## #   Source <chr>, Language <chr>, Catalog <chr>, Frequency <chr>, Period <chr>,
    ## #   SummaryAndLinks <chr>, ApiUrl <chr>, FeedUrl <chr>,
    ## #   DefaultPresentation <chr>, DefaultSelection <chr>, GraphTypes <chr>,
    ## #   RecordCount <int>, ColumnCount <int>, SearchPriority <chr>

or do a search:

``` r
res <- cbs_search("apple", language="en")
res[1:3, c(1:4)]
```

    ## # A tibble: 3 × 4
    ##    score Updated             Identifier Title                                   
    ##    <dbl> <dttm>              <chr>      <chr>                                   
    ## 1 0.0503 2023-12-07 00:00:00 85680ENG   Trade in goods; border crossing, SITC (…
    ## 2 0.0356 2023-12-07 00:00:00 85683ENG   Trade in goods; border crossing, SITC (…
    ## 3 0.0337 2023-12-07 00:00:00 85682ENG   Trade in goods; border crossing, SITC (…

Use the `Identifier` from tables to retrieve table information

``` r
cbs_get_meta('71509ENG')
```

    ## 71509ENG: 'Yield apples and pears, 1997 - 2017', 2017
    ##   FruitFarmingRegions: 'Fruit farming regions'
    ##   Periods: 'Periods' 
    ## 
    ## Retrieve a default data selection with:
    ##  cbs_get_data(id = "71509ENG", FruitFarmingRegions = c("1", "2", 
    ## "4", "3", "5"), Periods = c("1997JJ00", "2012JJ00", "2013JJ00", 
    ## "2016JJ00"), select = c("FruitFarmingRegions", "Periods", "TotalAppleVarieties_1", 
    ## "CoxSOrangePippin_2", "DelbarestivaleDelcorf_3", "Elstar_4", 
    ## "GoldenDelicious_5", "Jonagold_6", "Jonagored_7", "RodeBoskoopRennetApple_10", 
    ## "OtherAppleVarieties_12", "TotalPearVarieties_13", "Conference_15", 
    ## "DoyenneDuComice_16", "CookingPears_17", "TriompheDeVienne_18", 
    ## "OtherPearVarieties_19", "TotalAppleVarieties_20", "CoxSOrangePippin_21", 
    ## "DelbarestivaleDelcorf_22", "Elstar_23", "GoldenDelicious_24", 
    ## "Jonagold_25", "Jonagored_26", "RodeBoskoopRennetApple_29", "OtherAppleVarieties_31", 
    ## "TotalPearVarieties_32", "Conference_34", "DoyenneDuComice_35", 
    ## "CookingPears_36", "TriompheDeVienne_37", "OtherPearVarieties_38"
    ## ))

Or download data.

``` r
library(dplyr) # just for example's sake
apples <- cbs_get_data("71509ENG") 

apples |> 
  select(1:4)
```

    ## # A tibble: 105 × 4
    ##    FruitFarmingRegions Periods  TotalAppleVarieties_1 CoxSOrangePippin_2
    ##    <chr>               <chr>                    <int>              <int>
    ##  1 1                   1997JJ00                   420                 43
    ##  2 1                   1998JJ00                   518                 40
    ##  3 1                   1999JJ00                   568                 39
    ##  4 1                   2000JJ00                   461                 27
    ##  5 1                   2001JJ00                   408                 30
    ##  6 1                   2002JJ00                   354                 17
    ##  7 1                   2003JJ00                   359                 17
    ##  8 1                   2004JJ00                   436                 14
    ##  9 1                   2005JJ00                   359                 12
    ## 10 1                   2006JJ00                   365                 11
    ## # ℹ 95 more rows

add label columns:

``` r
apples |> 
  cbs_add_label_columns() |> 
  select(1:4)
```

    ## # A tibble: 105 × 4
    ##    FruitFarmingRegions FruitFarmingRegions_label Periods  Periods_label
    ##    <chr>               <fct>                     <chr>    <fct>        
    ##  1 1                   Total Netherlands         1997JJ00 1997         
    ##  2 1                   Total Netherlands         1998JJ00 1998         
    ##  3 1                   Total Netherlands         1999JJ00 1999         
    ##  4 1                   Total Netherlands         2000JJ00 2000         
    ##  5 1                   Total Netherlands         2001JJ00 2001         
    ##  6 1                   Total Netherlands         2002JJ00 2002         
    ##  7 1                   Total Netherlands         2003JJ00 2003         
    ##  8 1                   Total Netherlands         2004JJ00 2004         
    ##  9 1                   Total Netherlands         2005JJ00 2005         
    ## 10 1                   Total Netherlands         2006JJ00 2006         
    ## # ℹ 95 more rows

For more information, see `vignette("cbsodataR")`

Python user? Use [cbsodata](https://github.com/J535D165/cbsodata).
