library(ngRok)
id <- ngRok::livestream_start('www.rdaviscode.com','nifflers','rdavis',8080)

library(lubridate)

dates <- c('2012-10-20','1932-11-10','1995-12-11','1993-10-1')

as.Date(dates)

# if you want to see the code to a function, sometimes you can just type the funciton and run it to see how it is set-up
as.Date

class(as.Date(dates))
as.Date

dates2 <- c('03-33-2020','11-10-1932','12-11-1995','10-1-1993')
as.Date(dates2)

?as.POSIXct

date_and_times <- c('03-33-2020 4:20:13','06-10-2022 6:30:12 GMT','12-11-1995 14:20:20','10-1-1993 18:10:10')

as.POSIXlt(date_and_times,format = '%m-%d-%Y %H:%M:%S')

as.Date(dates2,'%m-%d-%Y')
dates
ymd(dates)
dates3 <- c('20121020','19321110','19951211','1993101')
ymd(dates3)


dates2
mdy(dates2)
?year
day(mdy(dates2))


lubridate::
  ymd()
dmy()
mdy()
ymd_


# Function-writing ----
## What is a function?
## A series of commands/code wrapped into another command. Can be simple or complex. Almost all R is based on functions.


## Who gets to write functions?
## Anyone! Fancy coders put those functions in packages and host them on CRAN, but anyone can write a function and store it in their global environment


## How to write a function?
## 1. name it
## 2. assign it to do something using placeholders using curly brackets
## 3. deploy with the function function()

# convert 75 F to Kelvin
K <- ((75 - 32) * (5 / 9)) + 273.15

FtoK <- function(x){
  K <- ((x - 32) * (5 / 9)) + 273.15
  return(K)
}

FtoK(x = 75)


# Challenge: https://gge-ucd.github.io/R-DAVIS/lesson_13_functions.html#Challenge9

install.packages(gapminder)
library(gapminder)

# Challenge: https://gge-ucd.github.io/R-DAVIS/lesson_13_functions.html#Challenge9

## Code for setting up challenge is redundant. Could do either option and it would work --
## Option A:
d <- gapminder::gapminder
# looks inside gapminder package without loading it into the library
## Option B:
library(gapminder)
d <- gapminder # it knows where gapminder is because we loaded in the library

#Write a new function that takes two arguments, the gapminder data
#.frame (d) and the name of a country (e.g. "Afghanistan"), and plots #a time series of the country’s population. The return value from the #function should be a ggplot object. Note: It is often easier to #modify existing code than to start from scratch. To start out with #one plot for a particular country, figured out what you need to #change for each iteration (these will be your arguments), and then #wrap it in a function.

d <- gapminder::gapminder
library(tidyverse)
pop <- function(x){
  plot <- d %>%
    filter(country == x) %>%
    ggplot(aes(year, pop)) +
    geom_point() +
    geom_line() +
    theme_bw()
  return(plot)
}

pop("Benin")

pop("United States")

unique(d$country)

pop("Belgium")

pop("Zimbabwe")


countries <- unique(d$country)

for(i in countries){
  print(i)
}

for(i in countries){
  plot <- pop(i)
  print(plot)
}

## What if I wanted to add a title?






# Iteration -----
## Ieration = running the same function across multiple values (there are various iteration tools)


## Run this function over every country.
## What are the countries?
