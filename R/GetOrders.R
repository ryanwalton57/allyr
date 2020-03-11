#' @title Returns recent orders
#' @description Some placeholder
#' @export
#' @param APIKeys A character vector containing API keys (order: cKey, cSecret, oKey, oSecret).
#' @param acctNum Your Ally Invest account number
#' @return A tibble containing information on recent orders
#' @import ROAuth
#' @import tibble
#' @examples
#' \dontrun{
#' GetQuotes(APIKeys, xxxxxxxx)
#' }
#'

GetOrders <- function(APIKeys, acctNum) {

  if (!is.vector(APIKeys)) {
    stop("Please put your API keys in a vector.")
  }
  if (!is.character(APIKeys)) {
    stop("Your keys need to be character strings.")
  }

  getinfo.double <- function(searchString, order){
    firstPos <- regexpr(searchString, order)
    length <- nchar(searchString)
    keep <- substr(order, firstPos + length, nchar(order))
    lastPos <- regexpr('\"', keep)
    found <- substr(keep, 0, lastPos - 1)
    double <- as.double(found)
    return(double)
  }

  getinfo.character <- function(searchString, order){
    firstPos <- regexpr(searchString, order)
    length <- nchar(searchString)
    keep <- substr(order, firstPos + length, nchar(order))
    lastPos <- regexpr('\"', keep)
    found <- substr(keep, 0, lastPos - 1)
    return(found)
  }

  tkURL_holdings_p1 <- "https://api.tradeking.com/v1/accounts/"
  tkURL_holdings_p2 <- "/orders.xml"
  tkURL_orders <- paste(tkURL_holdings_p1,accountNum,tkURL_holdings_p2, sep = "")

  credentials <- OAuthFactory$new(consumerKey = APIKeys[1],
                                  consumerSecret = APIKeys[2],
                                  oauthKey = APIKeys[3],
                                  oauthSecret = APIKeys[4],
                                  needsVerifier = FALSE,
                                  signMethod='HMAC')

  # Update the connection so the handshake is TRUE
  credentials$handshakeComplete <- TRUE

  #Get Order
  response_get <- credentials$OAuthRequest(tkURL_orders, "GET")

  #Read order
  x <- read_xml(response_get)
  ord <- xml_text(xml_find_all(x, ".//order"))

  PxVec <- SymVec <- SecTypVec <- DescVec <- c()

  for (i in 1:length(ord)) {

    Px <- getinfo.double('Px=\"', ord[i])
    PxVec <- c(PxVec, Px)

    Sym <- getinfo.character('Sym=\"', ord[i])
    SymVec <- c(SymVec, Sym)

    SecTyp <- getinfo.character('SecTyp=\"', ord[i])
    SecTypVec <- c(SecTypVec, SecTyp)

    Desc <- getinfo.character('Desc=\"', ord[i])
    DescVec <- c(DescVec, Desc)

  }

  df <- tibble("Sym" = SymVec, "SecTyp" = SecTypVec, "Price" = PxVec, "Desc" = Desc)

  if (nrow(df) == 0) {
    warning("No recent orders to display.")
  }

  return(df)
}

