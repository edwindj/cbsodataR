# CBS odata with R

[![Travis-CI Build Status](https://travis-ci.org/edwindj/cbsodata.R.png?branch=master)](https://travis-ci.org/edwindj/cbsodata.R)

Retrieve data from the [open data interface](http://www.cbs.nl/nl-NL/menu/cijfers/statline/open-data/default.htm) of Statistics Netherlands (cbs.nl) with *R*.
The OData description 

__Note: This is a spare time project and not an official Statistics Netherlands package__

# Installation

`cbsodata` is not available from CRAN but can installed using `devtools`.

```S
devtools::install_github("edwindj/cbsodata.R")
```

# Usage

Retrieve list a tables.
```
tables <- get_tables(Language="en")
```

Use the `Identifier` from tables to retrieve table information

```

```


