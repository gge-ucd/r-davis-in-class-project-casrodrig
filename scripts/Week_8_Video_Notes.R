# Week 8 Video Notes----
# Video 1 -- Dates with Lubridate


# how to deal with dates and times in R with the lubridate package
install.packages(lubridate)
Library(lubridate)

# this is a bunch of convenience functions for dealing with dates and times, which are complex in R; there are 3 diff time classes in R, dates and times are still made up of character strings and numbers, but it is like a special wrapper that has been built around it. R recognized that we are talking about a date here and not any everyday string; it represents a special type of data and not just a character string; the three types of specialty date object wrappers: are dates, which are simply just a year, month, and day, 4 digits – 2 digits – 2 digits; like:

test_date <- as.Date("2020-01-01")
class(test_date)

# R will recognize this as a date object. The two other classes are posixsct and positslt; ct and lt are basically the same thing, they have a date and time and potentially a timezone stored with it;  so year, month, day, hour, minute, second, timezone; R stores them a bit differently; ct = calander time and lt = local time; in an error code if you ever see Posix_xys  know it is a date and time problem for date and time objects.

# The Date class in R can easily be converted or operated on numerically, depending on the interest. Let’s make a string of dates to use for our example:

sample_dates_1 <- c("2018-02-01", "2018-03-21", "2018-10-05", "2019-01-01", "2019-02-18")
#notice we have dates across two years here
# notice we have dates across two years here; try to make a date object:

as.Date(sample_dates_1)

# R does not know these are dates, just thinks they are arbitrary numbers and dashes; if we run this it looks identical, but you fed in what R is expecting a date to look like, which is not always the case if you feed in different orders; What happens with different orders…say MM-DD-YYYY?


sample_dates_2 <- c("02-01-2018", "03-21-2018", "10-05-2018", "01-01-2019", "02-18-2019")
as.Date(sample_dates_2)


sample_dates_3 <-as.Date(sample_dates_2) # well that doesn't work

# R does not know what to expect bc it is look for the order year, month, day; now it shows month, day, year; exact same dates but order is diff.; you got an NA from the second order bc there is no such thing as a 21st month, for instance…order matters

# there are ways to accommodate this; the reason this did not work is bc R was assuming a diff. order, YYYY-MM-DD, but there was a diff order, try this again, but tell R the order you are feeding things in; w/I the as.date function, you can call this format setting, what you do here is specify, instead of using the default settings, you can tell it the order the objects are in; the % is an indicator (for time value, m for month, d for day, y stands for year) some are upper case and lower case, the reason is bc month/day come in two digit format and year is a four digit format

# as.Date did not work, so let’s try something else



sample_dates_3 <-as.Date(sample_dates_2, format = %m-%d-%Y) 
# date code preceded by "%
sample_dates_3
# This works, bc coding as a date object it turns it into the preferable Y,M,D format; why does this matter? Bc if trying to sort by time, these are like character strings, so if you store your date object as y,m,d and arrane that it will do it in chronological order, sort of alphabetizes these character strings

# What is the class that R classifies this data as?
# R classifies our sample_dates_1 data as character data. Let’s transform it into 
# Dates. Notice that our sample_dates_1 is in a nice format: YYYY-MM-DD. This is # the format necessary for the function as.Date.
# The reason this doesn’t work is because the computer expects one thing, but is 
# getting something else. Remember, write code you can read and your computer
# can understand. So we need to give some more information here so R will interpret
# our data correctly.



# Two other examples:

as.Date("2016/01/01", format="%Y/%m/%d")

# using back slashes to divide up the y,m,d; this works = 2016-01-01
as.Date("05A21A2011", format="%mA%dA%Y")
# lets say that for whatever particular reason the character A was in between each of your values; you can define it that way in your format = and will get back = 2011-05-21
# so to ways to treat the date object, one way is to code in the format or if coded well you can rely on the default or hope the default can parse it; sometimes time is recorded in most date observations, it is reccomentded to use the POSIXct format which operates the same, but if you don’t have times it doesn’t necessarily matter, but if you do you will lose the info. So it will look for y,m,day and hr,min,sec in whatever time zone you are in, daylight time…you need to look out for that in case you don’t want it to fill a particular timezone
tm1 <- as.POSIXct("2016-07-24 23:55:26")
tm1
## [1] "2016-07-24 23:55:26 PDT"
# To see a list of the date-time format codes in R, check out this page and table, or
# you can use: ?(strptime)
# The nice thing is this method works well with pretty much any format, you just
# need to provide the associated codes and structure:
# just like using the % to specify the format for date, we can do the similarly the same with time…but with : 
tm2 <- as.POSIXct("25072016 08:32:07", format = "%d%m%Y %H:%M:%S")
tm2
## [1] "2016-07-25 08:32:07 PDT"
# call as.POSIXct you end up with a general format and call class to prove it:
class(tm2)
# it is a POSIX class object; it auto fills in timezones, but if you wanted to change this, you could specify, but have to specify it as a diff setting with tz = “”; 
#Notice how POSIXct automatically uses the timezone your computer is set to. What if we collected this data in a different timezone?

# specify the time zone:
tm3 <- as.POSIXct("2010-12-01 11:42:03", tz = "GMT")
tm3
## [1] "2010-12-01 11:42:03 GMT"
# lubridate works easily
# the lubridate package will handle 90% of the date & datetime issues you need to deal with. It is fast, much easier to work with, and we recommend using it wherever possible. Do keep in mind sometimes you need to fall back on the base R functions (i.e., as.Date()), which is why having a basic understanding of theses functions and their use is important.
# To use lubridate we will first need to install and load the package.
#install.packages("lubridate")

library(lubridate)
# lubridate has lots of handy functions for converting between date and time formats, and even timezones; instead of requiring you to come up with a fancy character string to parce format, it has a separate function for each order; for instance lets say you are feeding in dates in YMD order or DMY, luberdate has a function for both formats…and many more
ymd()
dmy("23-02-2020")
mdy()
ydm()
sample_dates_lub <- ymd(sample_dates_1) # store it
sample_dates_lub  # it will create a bunch of dates you wanted.
# all the same functions, but include all these wrappers that are intuitive bc you can say you have a set of character strings in a particular format (DMY), and will store it for you if you put in the correct order; intuitive bc rather than remembering the special character string format you can use these to help
# Let’s take a look at our sample_dates_1 data again.
sample_dates_1 <- c("2018-02-01", "2018-03-21", "2018-10-05", "2019-01-01", "2019-02-18")
# Once again, R reads this in a character data.
# Lubridate uses functions that looks like ymd or mdy to transform data into the class # “Date”. Our sample_dates_1 data is formatted like Year, Month, Day, so we would # use the lubridate function ymd (y = year, m = month, d = day).
# What about that messier sample_dates_2 data? Remember R wants dates to be in the format YYYY-MM-DD.
# couple of cool features; can also, once you have encoded it as a date, you can pull out diff elements of it; so if you call year on the sample dates lub object it will just call the year:
year(sample_dates_lub)
# same with month
month(sample_dates_lub)
# and days
days(sample_dates_lub)
# useful; try in a diff order
sample_dates_2 <- c("2-01-2018", "3-21-2018", "10-05-18", "01-01-2019", "02-18-2019")
#notice that some numbers for years and months are missing

sample_dates_lub2 <- mdy(sample_dates_2) #lubridate can handle it! 
# this is not doing anything diff then the actual base R, but in nice packages that make life easier for the rest of us; few sample codes show how to use diff dates in diff order and you end up with the same results

#lubridate has very similar functions to handle data with Times and Timezones. To # the ymd function, add _hms or _hm (h= hours, m= minute, s= seconds) and 
# just like ymd
ymd_h
ymd_m
ymd_s
ymd_hms
# nice feature bc don’t always have data to the second, may only have hours or seconds…you can parse any of those formats…same as timzones…just like with AsPOSIX, just a little bit user friendly

# a tz argument. lubridate will default to the POSIXct format.
# Example 1: lubridate::ymd_hm("2016-01-01 12:00", tz="America/Los_Angeles") = 2016-01-01 12:00:00
# Example 2 (24 hr time): lubridate::ymd_hm("2016/04/05 14:47", tz="America/Los_Angeles") = 2016-04-05 14:47:00
# Example 3 (12 hr time but converts to 24): lubridate::ymd_hms("2016/04/05 4:47:21 PM", tz="America/Los_Angeles") = 2016-04-05 16:47:21
# For lubridate to work, you need the column datatype to be character or factor. 
# The readr package (from the tidyverse) is smart and will try to guess for you. 
# Problem is, it might convert your data for you without the settings (in this case the # proper timezone). So here are few ways to work around this.
# other tips: 
library(lubridate)
library(dplyr)
library(readr) #convience func for reading in data

# read in some data and skip header lines
nfy1 <- read_csv("data/2015_NFY_solinst.csv", skip = 12)
head(nfy1) #R tried to guess for you that the first column was a date and the second a time
## # A tibble: 6 × 5
##   Date       Time      ms Level Temperature
##   <date>     <time> <dbl> <dbl>       <dbl>
## 1 2015-05-22 14:00      0 -8.68           0
## 2 2015-05-22 14:15      0 -8.29           0
## 3 2015-05-22 14:30      0 -8.29           0
## 4 2015-05-22 14:45      0 -8.29           0
## 5 2015-05-22 15:00      0 -8.30           0
## 6 2015-05-22 15:15      0 -8.29           0
# import raw dataset & specify column types
nfy2 <- read_csv("data/2015_NFY_solinst.csv", col_types = "ccidd", skip=12)

glimpse(nfy1) # notice the data types in the Date.Time and datetime cols
## Rows: 7,764
## Columns: 5
## $ Date        <date> 2015-05-22, 2015-05-22, 2015-05-22, 2015-05-22, 2015-05-2…
## $ Time        <time> 14:00:00, 14:15:00, 14:30:00, 14:45:00, 15:00:00, 15:15:0…
## $ ms          <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
## $ Level       <dbl> -8.6834, -8.2928, -8.2914, -8.2901, -8.2955, -8.2935, -8.2…
## $ Temperature <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
glimpse(nfy2)
## Rows: 7,764
## Columns: 5
## $ Date        <chr> "2015/05/22", "2015/05/22", "2015/05/22", "2015/05/22", "2…
                         ## $ Time        <chr> "14:00:00", "14:15:00", "14:30:00", "14:45:00", "15:00:00"…
                         ## $ ms          <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
                         ## $ Level       <dbl> -8.6834, -8.2928, -8.2914, -8.2901, -8.2955, -8.2935, -8.2…
                         ## $ Temperature <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
                         # Next we want to create a single datetime column. How do we get our Date and 
                         # Time columns into one column so we can format it as a datetime? The answer is 
                         # the paste function.
                         # paste() allows pasting text or vectors (& columns) by a given separator that you 
                         # specify with the sep = argument
                         # paste0() is the same thing, but defaults to using no separator (i.e. no space).
                         # make a datetime col:
                         nfy2$datetime <- paste(nfy2$Date, " ", nfy2$Time, sep = "")
                         
                         glimpse(nfy2) #notice the  datetime column is classifed as character
                         ## Rows: 7,764
                         ## Columns: 6
                         ## $ Date        <chr> "2015/05/22", "2015/05/22", "2015/05/22", "2015/05/22", "2…
                         ## $ Time        <chr> "14:00:00", "14:15:00", "14:30:00", "14:45:00", "15:00:00"…
                         ## $ ms          <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
                         ## $ Level       <dbl> -8.6834, -8.2928, -8.2914, -8.2901, -8.2955, -8.2935, -8.2…
                         ## $ Temperature <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0…
                         ## $ datetime    <chr> "2015/05/22 14:00:00", "2015/05/22 14:15:00", "2015/05/22 …
                         
                         # convert Date Time to POSIXct in local timezone using lubridate
                         nfy2$datetime_test <- as_datetime(nfy2$datetime, 
                                                           tz="America/Los_Angeles")
                         # OR convert using the ymd_functions
                         nfy2$datetime_test2 <- ymd_hms(nfy2$datetime, tz="America/Los_Angeles")
                         
                         # OR wrap in as.character()
                         nfy1$datetime <- ymd_hms(as.character(paste0(nfy1$Date, " ", nfy1$Time)), tz="America/Los_Angeles")
                         tz(nfy1$datetime)
                         ## [1] "America/Los_Angeles"
                         # Last, lubridate lets you extract components of date, time and datetime data types # with intuitive functions.
                         # Functions called day(), month(), year(), hour(), minute(), second(), etc... will extract those elements of a datetime column.
                         months <- month(nfy2$datetime)
                         # Use the table function to get a quick summary of categorical variables
                         table(months)
                         ## months
                         ##    5    6    7    8 
                         ##  904 2880 2976 1004
                         # Add label and abbr agruments to convert numeric representations to have names
                         months <- month(nfy2$datetime, label = TRUE, abbr=TRUE)
                         table(months)
                         ## months
                         ##  Jan  Feb  Mar  Apr  May  Jun  Jul  Aug  Sep  Oct  Nov  Dec 
                         ##    0    0    0    0  904 2880 2976 1004    0    0    0    0
                         
                         
--------------------------------------------------

# Video 2 -- Functioning-Writing
                           
# been using functions, it is a pre-written set of commands in R that you will use to accomplish a certain goal; learning diff funcitons, and how we can use them to wrangle certain data and plot....written by someone in the R world for base functionality of R
                           
# today we will talk about how and why to start writing your own local functions to make your coding easier; start with a basic function to give foundations of writing and then apply to some things we have been doing in class
                           
# at a basic level we start out doing some simple computation in R, say want to convert temp from F to Kelvin

# Temperature Conversion: F to Kelvin
                           
((75 - 32) * (5/9) + 273.15  # formula for converting
 
 # say you want to make this conversion on a whole set of numbers; you would copy and paste and add the new values of F for a bunch of diff temps
((46 - 32) * (5/9) + 273.15
((49 - 32) * (5/9) + 273.15
  
# when you find yourself writing out a string of commands in R, and then changing one or two values, you are pretty much in the market for writing your own funciton; the way we write our own function is a little bit meta; there is a function called function for function writing; even writing a function is based on writing a function someone else wrote; so how does this function function work
 
# to start, first write out your function commands once or twice and ask yourself, what is it in this string of commands I change between every time I have copied and pasted; with the above example it was the value that represents our Farenheit value (F); first step in a function is to identify what changes, which will be called your argument and then you will want to remove it from the code body and place into the function's function...
  
# function 'function() for function writing
  # 1. identify what changes -- this is your argument
  # 2. remove from the cody body, and place into the function function()
  
  ((75 - 32) * (5/9) + 273.15 # so rx 75 and replace with object name, which can be anything you want, most convential is to call it (x), but we can also call it something that has meaning to it (tempF) for temperature in Farenheit
    
# now we have created this object inside our command that right now if we ran it would be meaningless bc tempF doesn't exist, but we will use the function function() to make it exist; we have to give a name to our function just as we gave a name to our objects, so we can call it F_to_K, bc converting F to K; then use assignment arrow to open up our functino function() and what goes inside the parentheses are the arguments you would like to itterate across; in this case you will take the value that we sort of generalized inside our line of commands (tempF) and that is what will become a function argument inside the function we are creating called F_to_K; now we will need to fill the inside of the body itself; what we do is just take the generalized bit of code with the argument inside it and stick it inside the curley brackets {} and this is how we tell R these are the commands I want to happen inside the function

F_to_K <- function(tempF){
  (tempF - 32) * (5/9) + 273.15
  }
# output; now we have our own function category with one argument called tempF in the global environment; the way this works now, is the F_to_K function is now built into my computer, so can start typing it and it will pop up automoatically; and you have to give it one value which is that tempF value:

F_to_K(75)
F_to_K(46)
F_to_K(49)

# but instead of copying and pasting the formula, it is now embedded into the function you created; then you get the conversion output in the console; this is a pretty simple set of one line commands; not as useful, but you can still condense a bunch of diff code to some diff values and then use the function over and over again; next video and next week will get into more itterations, so how to itterate across this more smoothly; one thing to point out is the vocabulary here called a pass-by value

## pass-by value: Where is K? it is kind of like a "ghost" object -- it does not save into your global environmental, this is why you need to use the return() function; what is meant here (in the previous function it was specified and worked for now, but typically it is done diff) when you are creating a function and using a set of commands you often want to define a pass-by value, which is an object inside a function that will actually only exist inside the function, so inside the code chuck you are assigning this converted value to K, but bc it only exists inside the function you want to make sure you tell R to return the value of K; so print it out when the function is done running; so update your function here so it has the value K in it:

F_to_K <- function(tempF){
  K <- (tempF - 32) * (5/9) + 273.15
        return(K)
  }

# then when you run this function you should get the same result in the console, but in the global environment the value K has not populated bc that value K exists only insie of that function; and while inside this simple example it did not matter that the pass-by value was assigned or not, it is more important for inside more complex function writing, which we will do next; it won't be saved inside the function environment, but will only be saved outside the function environment

F_to_K(75)
F_to_K(46)
F_to_K(49)


## Plotting example

# an example that is a little more complex; when things become more comlex you may find yourself asking why you want to do this when copying and pasting a simple amount of code, it's whatever, but when you find yourself copying and pasting extensive lines of code and only changing one or two things at a time is when this comes in handy; so read in surveys data and create a plot so you can see how to write a function around a plot quite quickly

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

# say wanted to make a plot with just one of the spp ID in the data
table(surveys$species_id)

# so take surveys dataframe and use the filter function bc we want a specific value from a specific column; and also bc we are plotting and don't want to deal with NAs right now within weight bc we will use this to plot and filter out NAs in hindfoot_length; use ggplot to make a simple scatter plot; assign x to weight and y to hindfoot_length, so two continuous variables, which means we should add geom_jitter to add a point, and add a few fancy things by making alpha 0.5 for more transparency to see through the points a bit; also add some labels, labs layer helps if you really want to start making a cleaner plot with axes names that are better than your column names, for instance, you can rewrite them with the lab function where you just have x = that will be your x-axis and y = in your y-axis and title = will be the name you want the plot to be; then throw in a theme to look professional; this plot is a subset of the data, it's only for PE species

surveys %>% 
  filter(species_id == "PE" & !is.na(weight) & !is.na(hindfoot_length)) %>% 
  ggplot(aes(x = weight, y = hindfoot_length)) +
  geom_jitter(alpha = 0.5) +
  labs(x = "Weight", y = "Hindfoot length", title = "PE weight x hidfoot") + theme_bw()

# now we have learned how to use faceting to make lots of plots at once, but there are some circumstances where you might not want to facet, you might actually want to make individual plots at once; if you were interested in writing a function you might say ok, i want to make this for a bunch of other spp, and say ok i will copy it and replace the bits where i called out PE with other spp id names; which you would replace the new name where you specified it (in the spp id w/i the filter, and the title); maybe you want to make them for all of the spp names...and you keep copying and pasting; but when you get tired of this and have to go in and edit a ton of them, now this is where you might want to write a function for this; these are a lot longer code chunks and makes a lot of sense to write a function, following the principles of how you would write a function

surveys %>% 
  filter(species_id == "PL" & !is.na(weight) & !is.na(hindfoot_length)) %>% 
  ggplot(aes(x = weight, y = hindfoot_length)) +
  geom_jitter(alpha = 0.5) +
  labs(x = "Weight", y = "Hindfoot length", title = "PL weight x hidfoot") + theme_bw()

# typically start with the code itself and ask yourself what it is that you change every time i copy and paste, for here it is the spp_ID in the filter and the title; so replace these values with our argument words (whatever you want), here we will name it (to find them easier put them in all caps) SPECIES for the species_id within the filter and PLOTTITLE for the title in the labs that will be the arguments w/i the function; name the plot function something generic like plot_fx; open up the function function() and remember inside the function () the thing you put are whatever you decided to rename the objects below; this one now has two arguments, seperated by a comma; you can add more and more arguments depending on the complexity of what you are trying to achieve; it's your so you can do what you want but keep track of what you are manipulating; then put it into the function brackets; before we assign it to an object, lets see what it does if we don't assign it to an object and run it

plot_fx <- function(SPECIES, PLOTTITLE){
  surveys %>% 
    filter(species_id == SPECIES & !is.na(weight) & !is.na(hindfoot_length)) %>% 
    ggplot(aes(x = weight, y = hindfoot_length)) +
    geom_jitter(alpha = 0.5) +
    labs(x = "Weight", y = "Hindfoot length", title = PLOTTITLE) + theme_bw()
}

# shows up in the environment so now lets see if it works by opening up the plot funtion; we know it has two arguments, spp and plot title, let's see if it creates one we want, such as "SH" and title it "SH weight x hindfoot"

plot_fx("SH", "SH weight x hindfoot")

# it worked, so we still have not proven why you need to assign objects inside functions; it will probably be more important for itteration in our next lesson; but lets do it anyway

plot_fx <- function(SPECIES, PLOTTITLE){
  plot <- surveys %>% 
    filter(species_id == SPECIES & !is.na(weight) & !is.na(hindfoot_length)) %>% 
    ggplot(aes(x = weight, y = hindfoot_length)) +
    geom_jitter(alpha = 0.5) +
    labs(x = "Weight", y = "Hindfoot length", title = PLOTTITLE) + theme_bw()
  return(plot)
}

plot_fx("PL", "PL weight x hindfoot")

# change the return to print bc it will be useful with the ittertions later

plot_fx <- function(SPECIES, PLOTTITLE){
  plot <- surveys %>% 
    filter(species_id == SPECIES & !is.na(weight) & !is.na(hindfoot_length)) %>% 
    ggplot(aes(x = weight, y = hindfoot_length)) +
    geom_jitter(alpha = 0.5) +
    labs(x = "Weight", y = "Hindfoot length", title = PLOTTITLE) + theme_bw()
  print(plot)
}

plot_fx("PL", "PL weight x hindfoot")

# we now have identified how to write functions, know the basic architecture, and hopefully starting to see the point, instead of copying and pasting all those ggplot lines of code, we can now put it one time into a function where all we have to change are the arguments as they change, that way if all you want to do is add something, like a color, and want them all to be blue, now you will only have to go change it within the function and it can be applied to all, instead of reassigning the color argument inside of one code

plot_fx <- function(SPECIES, PLOTTITLE){
  plot <- surveys %>% 
    filter(species_id == SPECIES & !is.na(weight) & !is.na(hindfoot_length)) %>% 
    ggplot(aes(x = weight, y = hindfoot_length)) +
    geom_jitter(alpha = 0.5, color = "blue") +
    labs(x = "Weight", y = "Hindfoot length", title = PLOTTITLE) + theme_bw()
  print(plot)
}
plot_fx("PL", "PL weight x hindfoot")

