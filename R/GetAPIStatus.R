#' @title GetAPIStatus
#' @description Returns the API status
#' @export
#' @return A message containing the API status
#' @import httr
#' @examples
#' \dontrun{
#' GetAPIStatus()
#' }
#'


GetAPIStatus <- function() {
  status <- GET("https://api.tradeking.com/v1/utility/status.xml")
  if (status$status_code != 200)
    print("The API appears to be down.")
  else
    print("The API is available.")
}
