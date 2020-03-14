#' @title GetAccountHoldings
#' @description Returns information on your current account holdings.  Requires API keys (in specific order). See help for more info.
#' @export
#' @param APIKeys A vector containing API keys (order: cKey, cSecret, oKey, oSecret).
#' @param acctNum An Ally Invest account number.
#' @return A tibble containing curret account holdings for the account passed..
#' @import ROAuth
#' @import xml2
#' @import tibble
#' @examples
#' \dontrun{
#' GetAccountHoldings (APIKeys, xxxxxxxx)
#' }
#'
#'
GetAccountHoldings <- function(APIKeys, acctNum) {

  if (!is.vector(APIKeys)) {
    stop("Please put your API keys in a vector.")
  }
  if (!is.character(APIKeys)) {
    stop("Your keys need to be character strings.")
  }

  # Set the API endpoint
  tkURL_holdings_p1 <- "https://api.tradeking.com/v1/accounts/"
  tkURL_holdings_p2 <- "/holdings.xml"
  tkURL_holdings <- paste(tkURL_holdings_p1,acctNum,tkURL_holdings_p2, sep = "")
  # Create the OAuth connection - this is straight from the ROAuth documentation on CRAN
  credentials <- OAuthFactory$new(consumerKey = APIKeys[[1]],
                                  consumerSecret = APIKeys[[2]],
                                  oauthKey = APIKeys[[3]],
                                  oauthSecret = APIKeys[[4]],
                                  needsVerifier = FALSE,
                                  signMethod='HMAC')

  # Update the connection so the handshake is TRUE
  credentials$handshakeComplete <- TRUE

  #Make the request
  response_get <- credentials$OAuthRequest(tkURL_holdings, "GET")

  #Convert response into something readable
  doc <- read_xml(response_get)

  #Mine the desired fields
  sym <- xml_text(xml_find_all(doc, ".//sym"))
  desc <- xml_text(xml_find_all(doc, ".//desc"))
  price <- xml_text(xml_find_all(doc, ".//price"))
  putcall <- xml_text(xml_find_all(doc, ".//putcall"))
  qty <- xml_text(xml_find_all(doc, ".//qty"))
  sectyp <- xml_text(xml_find_all(doc, ".//sectyp"))

  df <- tibble("Sym" = sym, "Price" = price, "SecType" = sectyp, "PutOrCall" = putcall, "Qty" = qty, "Desc" = desc)
  return(df)
}
