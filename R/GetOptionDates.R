#' @title GetOptionDates
#' @description Returns expiration dates on a single underlying
#' @export
#' @param APIKeys A vector containing API keys (order: cKey, cSecret, oKey, oSecret).
#' @param symbol The underlying's symbol
#' @return A tibble containing available option expiration dates and days to expiration
#' @import ROAuth
#' @import tibble
#' @examples
#' \dontrun{
#' GetOptionDates(APIKeys, "XYZ"
#' }
#'

GetOptionDates <- function(APIKeys, symbol){

  if (!is.vector(APIKeys)) {
    stop("Please put your API keys in a vector.")
  }
  if (!is.character(APIKeys)) {
    stop("Your keys need to be character strings.")
  }
  if (!is.character(symbol)) {
    stop("The symbol passed must be a character string.")
  }

  tkURL_exp <- "https://api.tradeking.com/v1/market/options/expirations.xml"


  credentials <- OAuthFactory$new(consumerKey = APIKeys[1],
                                  consumerSecret = APIKeys[2],
                                  oauthKey = APIKeys[3],
                                  oauthSecret = APIKeys[4],
                                  needsVerifier = FALSE,
                                  signMethod='HMAC')

  # Update the connection so the handshake is TRUE
  credentials$handshakeComplete <- TRUE

  #Get Order
  response_get <- credentials$OAuthRequest(tkURL_exp, symbol)
  response_get

  x <- read_xml(response_get)
  dates <- xml_text(xml_find_all(x, ".//date"))
  dates <- as.Date(dates)
  today <- as.Date(Sys.Date())
  daysToExp <- c()

  for (i in 1:length(dates)) {

    daysToExp <- c(daysToExp, as.double(dates[i] - today))

  }

  dateTable <- tibble("Dates" = dates, "DTE" = daysToExp)
  return(dateTable)
}
