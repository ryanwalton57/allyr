#' @title Returns market quote (last, bid, ask) on a single stock
#' @description Some placeholder
#' @export
#' @param APIKeys A vector containing API keys (order: cKey, cSecret, oKey, oSecret).
#' @param symbol The underlying's symbol
#' @return A tibble containing the symbol, with last, bid, and ask prices.
#' @import ROAuth
#' @import tibble
#' @examples
#' \dontrun{
#' GetQuotes(APIKeys, "XYZ")
#' }
#'

GetQuote <- function(APIKeys, symbol){

  if (!is.vector(APIKeys)) {
    stop("Please put your API keys in a vector.")
  }
  if (!is.character(APIKeys)) {
    stop("Your keys need to be character strings.")
  }
  if (!is.character(symbol)) {
    stop("The symbol must be a character string.")
  }

  # Set the API endpoint
  tkURL <- "https://api.tradeking.com/v1/market/ext/quotes.json"
  # Create the OAuth connection - this is straight from the ROAuth documentation on CRAN
  credentials <- OAuthFactory$new(consumerKey = APIKeys[1],
                                  consumerSecret = APIKeys[2],
                                  oauthKey = APIKeys[3],
                                  oauthSecret = APIKeys[4],
                                  needsVerifier = FALSE,
                                  signMethod='HMAC')

  # Update the connection so the handshake is TRUE
  credentials$handshakeComplete <- TRUE
  # Create the parameters to be passed with the GET request
  query <- list()
  query[[ "symbols" ]] <- symbol
  query[[ "fids" ]] <- "last,bid,ask"
  # Make the GET request, passing along the parameters, storing the response, then parsing the response
  response <- credentials$OAuthRequest(tkURL, query)

  x <- fromJSON(response)
  prices <- as.double(x$response$quotes$quote[1:3])
  df <- tibble("Sym" = symbol, "Last" = prices[3], "Bid" = prices[2], "Ask" = prices[1])
  return(df)
}


