#' @title Returns the current market time
#' @description Some placeholder
#' @export
#' @return A tibble containing the symbol, with last, bid, and ask prices.
#' @import ROAuth
#' @import tibble
#' @examples
#' \dontrun{
#' GetQuotes(APIKeys, "XYZ")
#' }
#'

GetMarketTime <- function(){

  time <- httr::GET("https://api.tradeking.com/v1/market/clock.xml")

  if (time$status_code != 200) {
    stop("The API is down for maintenance. Please try again later.")
  }

  x <- read_xml(time)
  message <- xml_text(xml_find_all(x, ".//message"))
  df <- tibble("Date/Time" = time$date, "Status" = message)

  return(df)
}
