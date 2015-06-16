# CBS odata with R

[![Travis-CI Build Status](https://travis-ci.org/edwindj/cbsodataR.png?branch=master)](https://travis-ci.org/edwindj/cbsodataR)

Retrieve data from the [open data interface](http://www.cbs.nl/nl-NL/menu/cijfers/statline/open-data/default.htm) of Statistics Netherlands (cbs.nl) with *R*.
The OData description is in Dutch (Google translate to the rescue...)

__Note: This is a spare time project and not an official Statistics Netherlands package__

# Installation

`cbsodata` is not available from CRAN but can installed using `devtools`.

```S
devtools::install_github("edwindj/cbsodataR")
```

# Usage

Retrieve list a tables.
```
> tables <- get_table_list(Language="en")
```

Use the `Identifier` from tables to retrieve table information

```
> get_meta('71509ENG')

71509ENG: 'Yield apples and pears', 2013
  FruitFarmingRegions: 'Fruit farming regions'
  Periods: 'Periods' 
```

Or download data

``` 
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
