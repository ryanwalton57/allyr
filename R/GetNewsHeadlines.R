#' @title Returns news articles based on symbol and dates
#' @description Some placeholder
#' @export
#' @param authKeys A vector containing API keys (order: cKey, cSecret, oKey, oSecret).
#' @param symbol A ticker
#' @param maxhits The number of hits to display
#' @param endDate The end date, passed as two-digit month and two digit year, separated by a '/' (mm/dd)
#' @return A tibble containing news headlines from todays date to \code{enddate}
#' @examples
#' \dontrun{
#' GetNewsHeadlines(APIKeys, "aapl", "10", "02/27")
#' }
#'

GetNewsHeadlines <- function(APIKeys, symbol, maxhits, enddate) {

  if (!is.vector(APIKeys)) {
    stop("Please put your API keys in a vector.")
  }
  if (!is.character(APIKeys)) {
    stop("Your keys need to be character strings.")
  }
  if (!is.character(symbol)) {
    stop("The symbol passed must be a character string.")
  }
  if (!is.numeric(maxhits)) {
    stop("The maxhits passed is not numeric.")
  }
  # Set the API endpoint
  tkURL_news <- "https://api.tradeking.com/v1/market/news/search.xml"
  # Create the OAuth connection - this is straight from the ROAuth documentation on CRAN
  credentials <- OAuthFactory$new(consumerKey = APIKeys[1],
                                  consumerSecret = APIKeys[2],
                                  oauthKey = APIKeys[3],
                                  oauthSecret = APIKeys[4],
                                  needsVerifier = FALSE,
                                  signMethod='HMAC')

  # Update the connection so the handshake is TRUE
  credentials$handshakeComplete <- TRUE
  query <- list()
  query[[ "symbols" ]] <- symbol
  query[[ "maxhits" ]] <- maxhits
  query[[ "enddate" ]] <- enddate
  #Make the request
  response_get <- credentials$OAuthRequest(tkURL_news, query)

  #Convert response into something readable
  doc <- read_xml(response_get)
  #Mine the desired fields
  headline <- xml_text(xml_find_all(doc, ".//headline"))
  date <- xml_text(xml_find_all(doc, ".//date"))


  df <- tibble("Date" = date, "Headline" = headline)
  return(df)
}
