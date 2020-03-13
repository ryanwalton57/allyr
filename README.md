allyr
================

## Purpose

This package provides functions that allow easy interaction with Ally
Invest’s API.

Note: Some functions require authentication, so an Ally Invest trading
account and API access keys will be needed. These functions are detailed
below.

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
    ##  1 AAP   2.80  OPT     1         1.00  AAP Jun 19 2020 140.00 Call 
    ##  2 AXP   3.75  OPT     1         1.00  AXP Jul 17 2020 105.00 Call 
    ##  3 CAT   1.15  OPT     1         1.00  CAT Jun 19 2020 125.00 Call 
    ##  4 CAT   0.44  OPT     1         1.00  CAT Jun 19 2020 135.00 Call 
    ##  5 CAT   4.70  OPT     1         1.00  CAT Aug 21 2020 110.00 Call 
    ##  6 CTXS  5.10  OPT     1         1.00  CTXS Jun 19 2020 115.00 Call
    ##  7 CVX   1.78  OPT     1         1.00  CVX Jun 19 2020 97.50 Call  
    ##  8 CVX   0.35  OPT     1         1.00  CVX Jun 19 2020 110.00 Call 
    ##  9 CVX   5.50  OPT     1         1.00  CVX Sep 18 2020 87.50 Call  
    ## 10 DE    1.58  OPT     1         1.00  DE Jun 19 2020 175.00 Call  
    ## # … with 17 more rows

``` r
GetNewsHeadlines(APIKeys = APIKeys, symbol = "aapl", maxhits = 10, enddate = "03/01")
```

    ## # A tibble: 10 x 2
    ##    Date              Headline                                                   
    ##    <chr>             <chr>                                                      
    ##  1 9:16AM ET 3/13/2… Sector Update: Tech Majors Gain Pre-Market Friday          
    ##  2 9:01AM ET 3/13/2… Wall Street Set for Rebound After Massive Virus-Induced Se…
    ##  3 7:22AM ET 3/13/2… Analyst Actions: Wells Fargo Upgrades Apple to Overweight …
    ##  4 2:31AM ET 3/13/2… Market Chatter: Apple Resumes Operation of All Stores in C…
    ##  5 3:38PM ET 3/12/2… Market Chatter: Apple Reportedly Enters New Deals with Maj…
    ##  6 3:36PM ET 3/12/2… Market Chatter: Apple Reportedly Set to be Fined Next Week…
    ##  7 1:00PM ET 3/12/2… US Stocks Tumble Further Into Bear Market as Trump Says Do…
    ##  8 10:07AM ET 3/12/… Update: Wall Street Indexes Plunge After Coming Off Halt, …
    ##  9 9:29AM ET 3/12/2… Update: Wall Street Set for Another Slump as Virus-Induced…
    ## 10 9:07AM ET 3/12/2… Wall Street Set for Another Slump as Virus-Induced Selloff…

``` r
GetOptionDates(APIKeys = APIKeys, "aapl")
```

    ## # A tibble: 19 x 2
    ##    Dates        DTE
    ##    <date>     <dbl>
    ##  1 2020-03-13     0
    ##  2 2020-03-20     7
    ##  3 2020-03-27    14
    ##  4 2020-04-03    21
    ##  5 2020-04-09    27
    ##  6 2020-04-17    35
    ##  7 2020-04-24    42
    ##  8 2020-05-01    49
    ##  9 2020-05-15    63
    ## 10 2020-06-19    98
    ## 11 2020-07-17   126
    ## 12 2020-09-18   189
    ## 13 2020-10-16   217
    ## 14 2020-12-18   280
    ## 15 2021-01-15   308
    ## 16 2021-06-18   462
    ## 17 2021-09-17   553
    ## 18 2022-01-21   679
    ## 19 2022-06-17   826

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
    ## 1 aapl   258.  258.  258.

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
    ## 1 2020-03-13 16:18:25 Market is open
