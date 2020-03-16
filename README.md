allyr
================

## Purpose

This package provides functions that allow easy interaction with Ally
Invest’s API.

Note: Some functions require authentication, so an Ally Invest trading
account and API access keys will be needed. These functions are detailed
below. Details on API access can be found at
<https://www.ally.com/api/invest/documentation/getting-started/>

### Functions Requiring Authentication

`GetAccountHoldings()`

`GetNewsHeadlines()`

`GetOptionDates()`

`GetOrders()`

`GetQuotes()`

### Functions NOT Requiring Authentication

`GetAPIVersion()`

`GetAPIStatus()`

`GetMarketTime()`

## Examples

### Functions Requiring Authentication

``` r
GetAccountHoldings(APIKeys = APIKeys, acctNum = accountNum)
```

    ## # A tibble: 27 x 6
    ##    Sym   Price SecType PutOrCall Qty   Desc                        
    ##    <chr> <chr> <chr>   <chr>     <chr> <chr>                       
    ##  1 AAP   2.35  OPT     1         1.00  AAP Jun 19 2020 140.00 Call 
    ##  2 AXP   6.85  OPT     1         1.00  AXP Jul 17 2020 105.00 Call 
    ##  3 CAT   3.50  OPT     1         1.00  CAT Jun 19 2020 125.00 Call 
    ##  4 CAT   1.58  OPT     1         1.00  CAT Jun 19 2020 135.00 Call 
    ##  5 CAT   9.60  OPT     1         1.00  CAT Aug 21 2020 110.00 Call 
    ##  6 CTXS  13.30 OPT     1         1.00  CTXS Jun 19 2020 115.00 Call
    ##  7 CVX   1.95  OPT     1         1.00  CVX Jun 19 2020 97.50 Call  
    ##  8 CVX   0.50  OPT     1         1.00  CVX Jun 19 2020 110.00 Call 
    ##  9 CVX   5.70  OPT     1         1.00  CVX Sep 18 2020 87.50 Call  
    ## 10 DE    1.50  OPT     1         1.00  DE Jun 19 2020 175.00 Call  
    ## # … with 17 more rows

``` r
GetNewsHeadlines(APIKeys = APIKeys, symbol = "aapl", maxhits = 10, enddate = "03/01")
```

    ## # A tibble: 10 x 2
    ##    Date              Headline                                                   
    ##    <chr>             <chr>                                                      
    ##  1 10:02AM ET 3/16/… Equities Crater to Trigger Trading Halt in Early US Sessio…
    ##  2 9:24AM ET 3/16/2… Wall Street Sees Another Round of Heavy Losses as Fed Slas…
    ##  3 9:01AM ET 3/16/2… Sector Update: Tech Heavyweights Decline Pre-Bell Monday   
    ##  4 8:50AM ET 3/16/2… Research Alert: CFRA Maintains Buy Opinion On Shares Of Ap…
    ##  5 8:44AM ET 3/16/2… Sector Update: Tech                                        
    ##  6 8:20AM ET 3/16/2… US Futures Slump as Fed Slashes Rates                      
    ##  7 7:45AM ET 3/16/2… Apple Fined $1.23 Billion by French Competition Authority …
    ##  8 7:14AM ET 3/16/2… --Apple Fined 1.1 Billion Euros by French Competition Auth…
    ##  9 6:33AM ET 3/16/2… Hong Kong Hang Seng Tumbles 4% as COVID-19 Hits Chinese Ec…
    ## 10 4:46AM ET 3/16/2… More Stores to Shut Doors Due to Coronavirus Outbreak

``` r
GetOptionDates(APIKeys = APIKeys, "aapl")
```

    ## # A tibble: 18 x 2
    ##    Dates        DTE
    ##    <date>     <dbl>
    ##  1 2020-03-20     4
    ##  2 2020-03-27    11
    ##  3 2020-04-03    18
    ##  4 2020-04-09    24
    ##  5 2020-04-17    32
    ##  6 2020-04-24    39
    ##  7 2020-05-01    46
    ##  8 2020-05-15    60
    ##  9 2020-06-19    95
    ## 10 2020-07-17   123
    ## 11 2020-09-18   186
    ## 12 2020-10-16   214
    ## 13 2020-12-18   277
    ## 14 2021-01-15   305
    ## 15 2021-06-18   459
    ## 16 2021-09-17   550
    ## 17 2022-01-21   676
    ## 18 2022-06-17   823

``` r
GetOrders(APIKeys = APIKeys, acctNum = accountNum)
```

    ## Warning in GetOrders(APIKeys = APIKeys, acctNum = accountNum): No recent orders
    ## to display.

    ## # A tibble: 0 x 4
    ## # … with 4 variables: Sym <chr>, SecTyp <chr>, Price <dbl>, Desc <chr>

``` r
GetQuote(APIKeys = APIKeys, symbol = "aapl")
```

    ## # A tibble: 1 x 4
    ##   Sym    Last   Bid   Ask
    ##   <chr> <dbl> <dbl> <dbl>
    ## 1 aapl   255.  255.  255.

### Functions NOT Requiring Authentication

``` r
GetAPIVersion()
```

    ## [1] "1.0"

``` r
GetAPIStatus()
```

    ## [1] "The API is available."

``` r
GetMarketTime()
```

    ## # A tibble: 1 x 2
    ##   `Date/Time`         Status        
    ##   <dttm>              <chr>         
    ## 1 2020-03-16 16:32:48 Market is open
