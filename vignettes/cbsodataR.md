
[Statistics Netherlands (CBS)](https://www.cbs.nl) is the office that
produces all official statistics of the Netherlands.

For long SN has put its data on the web in its online database
[StatLine](https://opendata.cbs.nl/statline#/CBS/en/). Since 2014 this
data base has an open data web API based on the OData protocol. The
*cbsodataR* package allows for retrieving data right into R.

## Table of Contents

A list of tables can be retrieved using the `cbs_get_datasets`
(`cbs_get_toc`) function.

``` r
library(dplyr) # not needed, but used in examples below
library(cbsodataR)

datasets <- cbs_get_datasets() 

datasets |> 
  filter(Language == "en") |> # only English tables
  select(Identifier, ShortTitle) 
```

    ## # A tibble: 1,005 × 2
    ##    Identifier ShortTitle                             
    ##    <chr>      <chr>                                  
    ##  1 80783eng   Agriculture; general farm type, region 
    ##  2 80784eng   Agriculture; labour force, region      
    ##  3 85636ENG   Arable crops; production               
    ##  4 37738ENG   Vegetables; yield per kind of vegetable
    ##  5 83981ENG   Livestock manure; key figures          
    ##  6 84952ENG   Livestock                              
    ##  7 7425eng    Milk supply and dairy production       
    ##  8 84312ENG   Caribbean NL; students MBO             
    ##  9 84732ENG   Caribbean NL; pupils and students      
    ## 10 81154eng   Caribbean NL; electricity and water    
    ## # ℹ 995 more rows

## Search for tables

Tables can be searched for using the `cbs_search` function.

``` r
toc_apples <- cbs_search(c("elstar", "apple"), language = "en")
toc_apples[, c("Identifier", "ShortTitle", "score")]
```

    ## # A tibble: 1 × 3
    ##   Identifier ShortTitle                          score
    ##   <chr>      <chr>                               <dbl>
    ## 1 71509ENG   Yield apples and pears, 1997 - 2017  2.64

## Other catalogs

Other catalogs with data are available:

``` r
catalogs <- cbs_get_catalogs()
catalogs$Identifier
```

    ##  [1] "CBS"      "MKB"      "IV3"      "MLZ"      "JM"       "RIVM"    
    ##  [7] "Politie"  "MVstat"   "AZW"      "InterReg" "SXstat"

## Metadata

Using an “Identifier” from `cbs_get_datasets` or `cbs_search`
information on the table can be retrieved with `cbs_get_meta`

``` r
apples <- cbs_get_meta('71509ENG')
apples
```

    ## 71509ENG: 'Yield apples and pears, 1997 - 2017', 2017
    ##   FruitFarmingRegions: 'Fruit farming regions'
    ##   Periods: 'Periods' 
    ## 
    ## Retrieve a default data selection with:
    ##  cbs_get_data(id = "71509ENG", select = c("FruitFarmingRegions", 
    ## "Periods", "TotalAppleVarieties_1", "CoxSOrangePippin_2", "DelbarestivaleDelcorf_3", 
    ## "Elstar_4", "GoldenDelicious_5", "Jonagold_6", "Jonagored_7", 
    ## "RodeBoskoopRennetApple_10", "OtherAppleVarieties_12", "TotalPearVarieties_13", 
    ## "Conference_15", "DoyenneDuComice_16", "CookingPears_17", "TriompheDeVienne_18", 
    ## "OtherPearVarieties_19", "TotalAppleVarieties_20", "CoxSOrangePippin_21", 
    ## "DelbarestivaleDelcorf_22", "Elstar_23", "GoldenDelicious_24", 
    ## "Jonagold_25", "Jonagored_26", "RodeBoskoopRennetApple_29", "OtherAppleVarieties_31", 
    ## "TotalPearVarieties_32", "Conference_34", "DoyenneDuComice_35", 
    ## "CookingPears_36", "TriompheDeVienne_37", "OtherPearVarieties_38"
    ## ), FruitFarmingRegions = c("1", "2", "4", "3", "5"), Periods = c("1997JJ00", 
    ## "2012JJ00", "2013JJ00", "2016JJ00"))

The meta object contains all metadata properties of cbsodata (see the
[original
documentation](https://www.cbs.nl/-/media/_pdf/2017/13/handleiding-cbs-open-data-services.pdf?la=nl-nl))
in the form of data.frames. Each data.frame describes properties of the
SN table.

``` r
names(apples)
```

    ## [1] "TableInfos"          "DataProperties"      "CategoryGroups"     
    ## [4] "FruitFarmingRegions" "Periods"

## Data download

With `cbs_get_data` data can be retrieved. By default all data for this
table will be downloaded in a temporary directory.

``` r
cbs_get_data('71509ENG') |> 
  select(1:4) |>  # demonstration purpose
  head()
```

    ## # A tibble: 6 × 4
    ##   FruitFarmingRegions Periods  TotalAppleVarieties_1 CoxSOrangePippin_2
    ##   <chr>               <chr>                    <int>              <int>
    ## 1 1                   1997JJ00                   420                 43
    ## 2 1                   1998JJ00                   518                 40
    ## 3 1                   1999JJ00                   568                 39
    ## 4 1                   2000JJ00                   461                 27
    ## 5 1                   2001JJ00                   408                 30
    ## 6 1                   2002JJ00                   354                 17

## Data download from a link

The opendata portal of CBS
(<https://opendata.cbs.nl/dataportaal/#/CBS/en>) allows for finding a
table and making a selection within this table manually. Such a
selection can be stored in a hyperlink (click the “share” button). This
link can also be used with `cbsodataR` using the
`cbs_get_data_from_link` function.

``` r
cbs_get_data_from_link("https://opendata.cbs.nl/dataportaal/#/CBS/en/dataset/71509ENG/table?dl=193CB") |> 
  select(1:4) |> 
  head()
```

    ## Executing:
    ## cbs_get_data(id = "71509ENG", select = c("FruitFarmingRegions", "Periods", "TotalAppleVarieties_1", "CoxSOrangePippin_2", "DelbarestivaleDelcorf_3", "Elstar_4", "GoldenDelicious_5", "Jonagold_6", "Jonagored_7", "Junami_8", "Kanzi_9", "RodeBoskoopRennetApple_10", "Rubens_11", "OtherAppleVarieties_12", "TotalAppleVarieties_20", "CoxSOrangePippin_21", "DelbarestivaleDelcorf_22", "Elstar_23", "GoldenDelicious_24", "Jonagold_25", "Jonagored_26", "Junami_27", "Kanzi_28", "RodeBoskoopRennetApple_29", "Rubens_30", "OtherAppleVarieties_31"), FruitFarmingRegions = c("1", "2", "3", "4", "5"), Periods = c("1997JJ00", "2012JJ00", "2013JJ00", "2016JJ00"), deeplink = "https://opendata.cbs.nl/dataportaal/#/CBS/en/dataset/71509ENG/table?dl=193CB",     base_url = "http://opendata.cbs.nl")

    ## # A tibble: 6 × 4
    ##      ID FruitFarmingRegions Periods  TotalAppleVarieties_1
    ##   <int> <chr>               <chr>                    <int>
    ## 1     0 1                   1997JJ00                   420
    ## 2    15 1                   2012JJ00                   282
    ## 3    16 1                   2013JJ00                   314
    ## 4    19 1                   2016JJ00                   317
    ## 5    21 2                   1997JJ00                    86
    ## 6    36 2                   2012JJ00                    34

### Adding category labels

The first columns are categorical columns: they contain codes. The
labels for these columns can be added with the function
`cbs_add_label_columns`.

``` r
cbs_get_data('71509ENG') |>
  cbs_add_label_columns() |> 
  select(1:4) |> 
  head()
```

    ## # A tibble: 6 × 4
    ##   FruitFarmingRegions FruitFarmingRegions_label Periods  Periods_label
    ##   <chr>               <fct>                     <chr>    <fct>        
    ## 1 1                   Total Netherlands         1997JJ00 1997         
    ## 2 1                   Total Netherlands         1998JJ00 1998         
    ## 3 1                   Total Netherlands         1999JJ00 1999         
    ## 4 1                   Total Netherlands         2000JJ00 2000         
    ## 5 1                   Total Netherlands         2001JJ00 2001         
    ## 6 1                   Total Netherlands         2002JJ00 2002

### Adding a Date column

The period/time columns of Statistics Netherlands (CBS) contain coded
time periods: e.g. 2018JJ00 (i.e. 2018), 2018KW03 (i.e. 2018 Q3),
2016MM04 (i.e. 2016 April). With `cbs_add_date_column` the time periods
will be converted and added to the data:

``` r
cbs_get_data('71509ENG') |>
  cbs_add_date_column() |> 
  select(2:4) |> 
  head()
```

    ## # A tibble: 6 × 3
    ##   Periods  Periods_Date Periods_freq
    ##   <chr>    <date>       <fct>       
    ## 1 1997JJ00 1997-01-01   Y           
    ## 2 1998JJ00 1998-01-01   Y           
    ## 3 1999JJ00 1999-01-01   Y           
    ## 4 2000JJ00 2000-01-01   Y           
    ## 5 2001JJ00 2001-01-01   Y           
    ## 6 2002JJ00 2002-01-01   Y

This can be useful for further time series analysis, but also for
displaying. It is also possible to convert the dates to numbers:

``` r
cbs_get_data('71509ENG') |>
  cbs_add_date_column(date_type = "numeric") |> 
  select(2:4) |> 
  head()
```

    ## # A tibble: 6 × 3
    ##   Periods  Periods_numeric Periods_freq
    ##   <chr>              <int> <fct>       
    ## 1 1997JJ00            1997 Y           
    ## 2 1998JJ00            1998 Y           
    ## 3 1999JJ00            1999 Y           
    ## 4 2000JJ00            2000 Y           
    ## 5 2001JJ00            2001 Y           
    ## 6 2002JJ00            2002 Y

### Adding unit columns

Each topic in the CBS data can have a unit, e.g. “%” or “mln kg”. Using
`cbs_add_unit_column` for each (specified) topic a unit column will be
added.

``` r
cbs_get_data('71509ENG') |>
  cbs_add_unit_column() |> 
  subset(,1:4) |>
  head()
```

    ## # A tibble: 6 × 4
    ##   FruitFarmingRegions Periods  TotalAppleVarieties_1 TotalAppleVarieties_1_unit
    ##   <chr>               <chr>                    <int> <chr>                     
    ## 1 1                   1997JJ00                   420 mln kg                    
    ## 2 1                   1998JJ00                   518 mln kg                    
    ## 3 1                   1999JJ00                   568 mln kg                    
    ## 4 1                   2000JJ00                   461 mln kg                    
    ## 5 1                   2001JJ00                   408 mln kg                    
    ## 6 1                   2002JJ00                   354 mln kg

## Select and filter

It is possible restrict the download using filter statements. This may
shorten the download time considerably.

### Filter

Filter statements for the columns can be used to restrict the download.
Note the following:

- To filter you will need to use the values found in the `$Key` column
  in the `cbs_get_meta` objects. e.g. for year 2020, the code is
  “2020JJ00”.

``` r
apples <- cbs_get_meta('71509ENG')
names(apples)
```

    ## [1] "TableInfos"          "DataProperties"      "CategoryGroups"     
    ## [4] "FruitFarmingRegions" "Periods"

``` r
# meta data for column Periods
head(apples$Periods[,1:2])
```

    ##        Key Title
    ## 1 1997JJ00  1997
    ## 2 1998JJ00  1998
    ## 3 1999JJ00  1999
    ## 4 2000JJ00  2000
    ## 5 2001JJ00  2001
    ## 6 2002JJ00  2002

``` r
#meta data for column FruitFarmingRegions
head(apples$FruitFarmingRegions[,1:2 ])
```

    ##   Key             Title
    ## 1   1 Total Netherlands
    ## 2   2      Region North
    ## 3   4       Region West
    ## 4   3    Region Central
    ## 5   5      Region South

- To filter for values in a column add `<column_name> = values` to
  `cbs_get_data` e.g. `Periods = c("2019JJ00", "2020JJ0")`

``` r
  cbs_get_data( '71509ENG'
              , Periods=c('2000JJ00','2001JJ00') # selection on Periods column
              , FruitFarmingRegions = "1" # selection on FruitFarmingRegions
              #
              # restrict the columns to the following as found in
              # apples$DataProperties with "select"
              , select = c("FruitFarmingRegions", "Periods", "TotalAppleVarieties_1")  
              ) |> 
  cbs_add_label_columns()
```

    ## # A tibble: 2 × 5
    ##   FruitFarmingRegions FruitFarmingRegions_label Periods  Periods_label
    ##   <chr>               <fct>                     <chr>    <fct>        
    ## 1 1                   Total Netherlands         2000JJ00 2000         
    ## 2 1                   Total Netherlands         2001JJ00 2001         
    ## # ℹ 1 more variable: TotalAppleVarieties_1 <int>

- To filter for values in a column that have a substring e.g. “JJ” you
  can use `<column_name> = has_substring(<substring>)` to `cbs_get_data`
  e.g. `Periods = has_substring("KW")`

``` r
  cbs_get_data( '71509ENG'
              , Periods = has_substring('2000') # selection on Periods column
              , FruitFarmingRegions = "1" # selection on FruitFarmingRegions
              #
              # restrict the columns to the following as found in
              # cbs_get_meta("71509ENG")$DataProperties with "select"
              , select = c("FruitFarmingRegions", "Periods", "TotalAppleVarieties_1")  
              ) |> 
    cbs_add_label_columns()
```

    ## # A tibble: 1 × 5
    ##   FruitFarmingRegions FruitFarmingRegions_label Periods  Periods_label
    ##   <chr>               <fct>                     <chr>    <fct>        
    ## 1 1                   Total Netherlands         2000JJ00 2000         
    ## # ℹ 1 more variable: TotalAppleVarieties_1 <int>

- To combine values and substring use the “\|” operator:
  `Periods = eq("2020JJ00") | has_substring("KW")`

``` r
  cbs_get_data( '71509ENG'
              , Periods = eq("2010JJ00") | has_substring('2000') # selection on Periods column
              , FruitFarmingRegions = "1" # selection on FruitFarmingRegions
              #
              # restrict the columns to the following as found in
              # cbs_get_meta("71509ENG")$DataProperties with "select"
              , select = c("FruitFarmingRegions", "Periods", "TotalAppleVarieties_1")  
              ) |> 
    cbs_add_label_columns()
```

    ## # A tibble: 2 × 5
    ##   FruitFarmingRegions FruitFarmingRegions_label Periods  Periods_label
    ##   <chr>               <fct>                     <chr>    <fct>        
    ## 1 1                   Total Netherlands         2000JJ00 2000         
    ## 2 1                   Total Netherlands         2010JJ00 2010         
    ## # ℹ 1 more variable: TotalAppleVarieties_1 <int>

# Download data

Data can also be downloaded explicitly by using `cbs_download_table`
