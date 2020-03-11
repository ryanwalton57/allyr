#' @title Returns the API status
#' @description Some placeholder
#' @export
#' @return A message containing the API status
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
