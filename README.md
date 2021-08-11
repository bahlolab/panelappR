
<!-- README.md is generated from README.Rmd. Please edit that file -->

## `panelAppR`: An R package to intefrace with the PanelApp API

### Installation

``` r
devtools::install_github("bahlolab/panelappR")
```

### Usage

-   Both [PanelApp Australia](https://panelapp.agha.umccr.org/) and
    [Genomics England PanelApp](https://panelapp.genomicsengland.co.uk/)
    are available. To access PanelApp Australia use `db = 'AGHA'`, and
    for Genomics England use `db = 'GE'`.
-   The function `list_panels` lists all available panels from a given
    source.
-   The function `get_panel` retrieves a specific panel by id.

``` r
panelappR::list_panels(db = 'AGHA') %>% 
  head()
## # A tibble: 6 x 13
##      id hash_id name  disease_group disease_sub_gro… status version
##   <int> <chr>   <chr> <chr>         <chr>            <chr>  <chr>  
## 1  3149 <NA>    Achr… Ophthalmolog… ""               public 1.3    
## 2   221 <NA>    Addi… Screening     ""               public 0.149  
## 3  3302 <NA>    Addi… Screening     ""               public 0.256  
## 4    36 <NA>    Alag… Dysmorphic a… ""               public 1.0    
## 5    40 <NA>    Alte… Neurology an… ""               public 0.49   
## 6  3564 <NA>    Amel… Skeletal dis… ""               public 0.1    
## # … with 6 more variables: version_created <chr>, relevant_disorders <list>,
## #   stats_number_of_genes <int>, stats_number_of_strs <int>,
## #   stats_number_of_regions <int>, types <list>
```

``` r
panelappR::get_panel(id = 3149, db = 'AGHA') %>% 
  head()
## # A tibble: 6 x 18
##      id names version entity_type entity_name confidence_level mode_of_pathoge…
##   <int> <chr> <chr>   <chr>       <chr>       <chr>            <chr>           
## 1  3149 Achr… 1.3     gene        ATF6        3                <NA>            
## 2  3149 Achr… 1.3     gene        CNGA3       3                <NA>            
## 3  3149 Achr… 1.3     gene        CNGB3       3                <NA>            
## 4  3149 Achr… 1.3     gene        GNAT2       3                <NA>            
## 5  3149 Achr… 1.3     gene        PDE6C       3                <NA>            
## 6  3149 Achr… 1.3     gene        PDE6H       3                <NA>            
## # … with 11 more variables: mode_of_inheritance <chr>, biotype <chr>,
## #   hgnc_id <chr>, gene_name <chr>, gene_symbol <chr>, hgnc_symbol <chr>,
## #   hgnc_release <chr>, hgnc_date_symbol_changed <chr>, alias <list>,
## #   phenotypes <list>, evidence <list>
```

``` r
panelappR::list_panels(db = 'GE') %>% 
  head()
## # A tibble: 6 x 13
##      id hash_id name  disease_group disease_sub_gro… status version
##   <int> <chr>   <chr> <chr>         <chr>            <chr>  <chr>  
## 1   399 <NA>    Addi… ""            ""               public 0.110  
## 2   933 <NA>    Addi… ""            ""               public 2.0    
## 3   929 <NA>    Addi… ""            ""               public 1.0    
## 4   930 <NA>    Addi… ""            ""               public 1.0    
## 5   934 <NA>    Addi… ""            ""               public 2.0    
## 6   931 <NA>    Addi… ""            ""               public 1.0    
## # … with 6 more variables: version_created <chr>, relevant_disorders <list>,
## #   stats_number_of_genes <int>, stats_number_of_strs <int>,
## #   stats_number_of_regions <int>, types <list>
```

``` r
panelappR::get_panel(id = 933, db = 'GE') %>% 
  head()
## # A tibble: 6 x 18
##      id names version entity_type entity_name confidence_level mode_of_pathoge…
##   <int> <chr> <chr>   <chr>       <chr>       <chr>            <chr>           
## 1   933 Addi… 2.0     gene        APC         3                ""              
## 2   933 Addi… 2.0     gene        APOB        3                "Loss-of-functi…
## 3   933 Addi… 2.0     gene        BRCA1       3                ""              
## 4   933 Addi… 2.0     gene        BRCA2       3                ""              
## 5   933 Addi… 2.0     gene        LDLR        3                ""              
## 6   933 Addi… 2.0     gene        MEN1        3                ""              
## # … with 11 more variables: mode_of_inheritance <chr>, biotype <chr>,
## #   hgnc_id <chr>, gene_name <chr>, gene_symbol <chr>, hgnc_symbol <chr>,
## #   hgnc_release <chr>, hgnc_date_symbol_changed <chr>, alias <list>,
## #   phenotypes <list>, evidence <list>
```

### Not (Yet) Implemented

-   Error checking (i.e. attempt to retrieve a non-existant panel)
-   Version specific queries - currently only the latest version of a
    panel is returned
