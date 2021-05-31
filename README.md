
# Statistics Netherlands (www.cbs.nl) opendata API client for R

[![version](http://www.r-pkg.org/badges/version/cbsodataR)](https://CRAN.R-project.org/package=cbsodataR)
![downloads](http://cranlogs.r-pkg.org/badges/cbsodataR) [![R build
status](https://github.com/edwindj/cbsodataR/workflows/R-CMD-check/badge.svg)](https://github.com/edwindj/cbsodataR/actions)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/edwindj/cbsodatar?branch=master)](https://ci.appveyor.com/project/edwindj/cbsodatar)

Retrieve data from the [open data
interface](http://www.cbs.nl/nl-NL/menu/cijfers/statline/open-data/default.htm)
(dutch) of Statistics Netherlands (cbs.nl) with *R*.

## Note for Windows 7/8 users

The security of the CBS web service has been updated, if you experience
problems, you can try the following:

``` r
Sys.setenv(CURL_SSL_BACKEND = "openssl")
options("url.method" = "libcurl")

toc <- cbs_get_toc()
View(toc)
```

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

# Usage (version 0.3+)

Retrieve a table of contents with all SN tables.

``` r
library(cbsodataR)
ds <- cbs_get_datasets("Language" = "en")
head(ds)
```

    ## # A tibble: 6 x 25
    ##   Updated             Identifier Title   ShortTitle  ShortDescription   Summary 
    ##   <dttm>              <chr>      <chr>   <chr>       <chr>              <chr>   
    ## 1 2021-03-19 00:00:00 80783eng   Agricu… Agricultur… "\nThis table con… "Agricu…
    ## 2 2021-03-19 00:00:00 80784eng   Agricu… Agricultur… "\nThis table con… "Agricu…
    ## 3 2021-03-31 00:00:00 7100eng    Arable… Arable cro… "\nThis table pro… "Area a…
    ## 4 2019-04-12 00:00:00 70671ENG   Fruit … Fruit cult… "\nThis table pro… "Cultiv…
    ## 5 2021-03-31 00:00:00 37738ENG   Vegeta… Vegetables… "\nThis table pro… "Area a…
    ## 6 2021-02-15 00:00:00 83981ENG   Livest… Livestock … "\nThis table com… "Manure…
    ## # … with 19 more variables: Modified <dttm>, MetaDataModified <dttm>,
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

    ## # A tibble: 3 x 4
    ##   score Updated             Identifier Title                                    
    ##   <dbl> <dttm>              <chr>      <chr>                                    
    ## 1 16.0  2019-04-12 00:00:00 71509ENG   Yield and cultivation area apples and pe…
    ## 2 10.3  2019-04-12 00:00:00 70671ENG   Fruit culture; area fruit orchards, sort…
    ## 3  1.42 2015-05-22 00:00:00 81894ENG   Health accounts; providers and financing…

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

apples %>% 
  select(1:4)
```

    ## # A tibble: 105 x 4
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
    ## # … with 95 more rows

add label columns:

``` r
apples %>% 
  cbs_add_label_columns() %>% 
  select(1:4)
```

    ## # A tibble: 105 x 4
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
    ## # … with 95 more rows

For more information, see `vignette("cbsodataR")`

Python user? Use [cbsodata](https://github.com/J535D165/cbsodata).
