#' @title GetAPIVersion
#' @description Returns the API verion
#' @export
#' @return A character string containing the API version
#' @import xml2
#' @import httr
#' @examples
#' \dontrun{
#' GetAPIVersion()
#' }
#'

GetAPIVersion <- function() {
  status <- GET("https://api.tradeking.com/v1/utility/version.xml")
  if (status$status_code != 200)
    stop("The API appears to be down.")
  x <- read_xml(status)
  message <- xml_text(xml_find_all(x, ".//version"))
  return(message)
}