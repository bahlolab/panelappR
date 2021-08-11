
get_base_url <- function(db = c('AGHA', 'GE')) {
  db <- match.arg(db)
  if (db == 'AGHA') {
    return("https://panelapp.agha.umccr.org/")
  }
  if (db == 'GE') {
    return("https://panelapp.genomicsengland.co.uk/")
  }
}

#'@importFrom dplyr tibble as_tibble bind_rows "%>%"
#'@importFrom httr GET accept_json content
#'@importFrom purrr map_df
#'@importFrom stringr str_c
#'@export
list_panels <- function(db = c('AGHA', 'GE')) {
  base_url <- get_base_url(match.arg(db))
  url <- str_c(base_url, 'api/v1/panels/')
  res <- tibble()
  while (TRUE) {
    response <- GET(url, accept_json()) %>% content()
    results <-
      response$results %>%
      map_df(function(x) {
        if (is.null(x$hash_id)) {
          x$hash_id <- NA_character_
        }
        types <- x$types
        x$types <- NULL
        stats <- x$stats
        x$stats <- NULL
        if (length(x$relevant_disorders) == 0) {
          x$relevant_disorders <- list(character())
        } else {
          x$relevant_disorders <- list(x$relevant_disorders)
        }
        x <- c(x,
               setNames(stats, str_c('stats_', names(stats))),
               list(types = list(map_df(types, as_tibble))))
        as_tibble(x)
      })

    res <- bind_rows(res, results)
    if (is.null(response$`next`)) { break }
    url <- response$`next`
  }
  return(res)
}

#'@importFrom dplyr tibble as_tibble bind_rows mutate bind_cols
#'@importFrom tidyr unnest
#'@importFrom httr GET accept_json content
#'@importFrom purrr map_df map
#'@importFrom stringr str_c
#'@importFrom rlang is_scalar_integerish
#'@export
get_panel <- function(id, db = c('AGHA', 'GE')) {
  base_url <- get_base_url(match.arg(db))
  stopifnot(is_scalar_integerish(id))
  url <- str_c(base_url, 'api/v1/panels/', id, '/')
  res <-
    GET(url, accept_json()) %>%
    content() %>%
    (function(x) {
      tibble(id = x$id,
             names = x$name,
             version = x$version,
             gene_data = list(map_df(x$genes, function(y) {
               cols1 <- c("entity_type", "entity_name", "confidence_level",
                          "mode_of_pathogenicity", "mode_of_inheritance")
               cols2 <- c('biotype', 'hgnc_id', 'gene_name', 'gene_symbol',
                          'hgnc_symbol', 'hgnc_release', 'hgnc_date_symbol_changed')
               as_tibble(map(y[cols1], ~ `if`(is.null(.), NA_character_, .))) %>%
                 bind_cols(
                   as_tibble(map(y$gene_data[cols2], ~ `if`(is.null(.), NA_character_, .)))) %>%
                 mutate(alias = list(y$gene_data$alias),
                        phenotypes = list(unlist(y$phenotypes)),
                        evidence = list(unlist(y$evidence)))
             })))
      }) %>%
    unnest(gene_data)
  return(res)
}

