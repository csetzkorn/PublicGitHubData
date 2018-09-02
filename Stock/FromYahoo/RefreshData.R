library(quantmod) 
library(xts)
library(tidyverse) 
library(stringr) 
library(forcats) 
library(lubridate) 

setwd('D:\\RProjects\\StockR\\YahooData\\')
Targets <- read.table('Technologies.txt', sep = '\t', header = TRUE)

get_stock_prices <- function(Targets, return_format = "tibble", ...) {
    # Get stock prices
    print(Targets[1])
    stock_prices_xts <- getSymbols(Symbols = Targets[1], auto.assign = FALSE, ...)
    # Rename
    names(stock_prices_xts) <- c("Open", "High", "Low", "Close", "Volume", "Adjusted")
    # Return in xts format if tibble is not specified
    if (return_format == "tibble") {
        stock_prices <- stock_prices_xts %>%
            as_tibble() %>%
            rownames_to_column(var = "Date") %>%
            mutate(Date = ymd(Date))
    } else {
        stock_prices <- stock_prices_xts
    }
    write.csv(stock_prices, file = paste(Targets[1], "csv", sep = '.'))
}

apply(Targets, 1, get_stock_prices)
