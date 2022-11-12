#Let’s look at some real data from Mauna Loa to try to format and plot. These meteorological data from Mauna Loa were collected every minute for the year 2001. This dataset has 459,769 observations for 9 different metrics of wind, humidity, barometric pressure, air temperature, and precipitation. Download this dataset here. Save it to your data/ folder. Alternatively, you can read the CSV directly from the R-DAVIS Github: mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

readme(mloa)
view(mloa)

#Use the README file associated with the Mauna Loa dataset to determine in what time zone the data are reported (it's reported in UTC), and how missing values are reported in each column (for wind direction Missing values are denoted by -999; for wind speed Missing values are denoted by -999.9; for wind steadiness factor Missing values are denoted by -9; for barometric pressure Missing values are denoted by -999.90; for temperature at 2 meter Missing values are denoted by -999.9; for temperature at 10 meteres Missing values are denoted by -999.9; for temperature at tower top Missing values are denoted by -999.9; for relative humidity Missing values are denoted by -99; for precipiation intensity Missing values are denoted by -99). With the mloa data.frame, remove observations with missing values in rel_humid, temp_C_2m, and windSpeed_m_s. Generate a column called “datetime” using the year, month, day, hour24, and min columns. Next, create a column called “datetimeLocal” that converts the datetime column to Pacific/Honolulu time (HINT: look at the lubridate function called with_tz()). Then, use dplyr to calculate the mean hourly temperature each month using the temp_C_2m column and the datetimeLocal columns. (HINT: Look at the lubridate functions called month() and hour()). Finally, make a ggplot scatterplot of the mean monthly temperature, with points colored by local hour.

# remove observations with missing values in rel_humid, temp_C_2m, and windSpeed_m_s (NAs)
filter(!is.na(real_humid) & !is.na(temp_C_2m) & !is.na(windSpeed_m_s)) %>%
  mutate(datetime = ymd_hm(pates0(year, "-", month, "-", day, "-", hour24, ":", min) tz = "UTC")) # using !is.na to remove the missing values from these columns

#Generate a column called “datetime” using the year, month, day, hour24, and min columns. #lubridate has very similar functions to handle data with Times and Timezones. To # the ymd function, add _hms or _hm (h= hours, m= minute, s= seconds);  # the paste function.
# paste() allows pasting text or vectors (& columns) by a given separator that you specify with the sep = argument; paste0() is the same thing, but defaults to using no separator (i.e. no space); dashes, -, are used for the dates and colons, :, for times

#Next, create a column called “datetimeLocal” that converts the datetime column to Pacific/Honolulu time (HINT: look at the lubridate function called with_tz()).
?with_tz 
# so tz will convert to whatever timezone you need it in with the with_tz function, with_tz, and te timezone mloa (and the locations Barrow, Alaska (BRW); Mauna Loa, Hawaii (MLO); American Samoa (SMO); Summit, Greenland (SUM); Trinidad Head, California (THD) and South Pole, Antarctica (SPO) is the Pacific/Honolulu tz (https://www.zeitverschiebung.net/en/timezone/pacific--honolulu); so we need to mutate this with_tz to get it set to the date-time in this different time zone; this readme file shows the timezone is set to UTC
?tz
?lubridate
?with_tz

# use dplyr to calculate the mean hourly temperature each month using the temp_C_2m column and the datetimeLocal columns. (HINT: Look at the lubridate functions called month() and hour()). 

?month
?hour
?`hour,Period-method`
?lubridate:hour24
?strftime
?`lubridate-package`

mutate(datetime = ymd_hm(paste0(year,"-", month, "-", day," ", hour24, ":", min), tz = "UTC")) # the date is set up as 2012-08-14 YYYY-MM-DD and the time is set up from 0 to 23, and signifies the beginning of the hour, 05:00 to 05:59, which means it spans across a 24 hour period in hours and minutes; can convert Date Time to POSIXct in local timezone using lubridate i.e., nfy2$datetime_test <- as_datetime(nfy2$datetime,tz="America/Los_Angeles");so I will want to mutate the datetime where it equal ymd_hm (year, month, day, hour, minute; and remember that - are for dates and : are for the hour and minute time blocks and this data is in UTC); use the paste0 function like paste() which allows pasting text or vectors (& columns) by a given separator that you specify with the sep = argument; paste0() is the same thing, but defaults to using no separator (i.e. no space). So we can tell R for the date (ymd) to pull from the year column, the month column, and the day column and then for time pull from the hour24 column and the min column 

# use dplyr to calculate the mean hourly temperature each month using the temp_C_2m column and the datetimeLocal columns. (HINT: Look at the lubridate functions called month() and hour()). Finally, make a ggplot scatterplot of the mean monthly temperature, with points colored by local hour.

#to calculate the mean hourly temp for each month with the temp_C_2m column and the datetimeLocal column I had to look back in week 5 video lectures; but I can do this with the mutate, group_by, and  summarize funcitons; since we want the monthly and hourly local datetimes we will have to mutate first with the lubridate month and hour functions using my mutated Local_datetime that is in the Pacific/Honolulu timezone that was created (see below...this took me a min to figure out what was going on and why this wasn't working); then using the group_by funciton we will want to group by the local_month_date (mutated) and the local_hour_time (mutated); then summarize it by the meantemps for temp_C_2m

# (make sure the label = true so it shows it as a character string with the actual month word); also pipe this all together to make it easer when I piece the whole thing at the end

mutate(local_month_date = month(Local_datetime, label = TRUE), local_hour_time = hour(Local_datetime)) %>% 
  group_by(local_month_date, local_hour_time) %>% 
  summarize(meantemp_C_2m = mean(temp_C_2m))

# ok and last we want to plot it using ggplot with the local_month_date on the x-axis and meantemp_C_2m on the y-axis, having the local_hour_time as my points for the geom_point; then make it professional looking

  ggplot(aes(x = local_month_date,
             y = meantemp_C_2m)) +
  geom_point(aes(col = local_hour_time)) +
  scale_color_binned() +
  xlab("Month") +
  ylab("Mean Temperature (degrees C)") +
  theme_dark()



  # need to put the date and times set locally to "Pacific/Honolulu" timezone so we can mutate it and set it in our function
mutate(mloa, Local_datetime = with_tz(datetime, tz = "Pacific/Honolulu"))


library(tidyverse)
library(lubridate)
 # Time to put it all together

# set up the data; I have to seperate the NA removals because for some reason I keep getting errors .... so i misunderstood and realized I was not removing NAs, i was suppose to rx the missing values that I had to obtain from the readme file.... I can use the filter function and the is not (!=) to remove the obtained missing values for each from the readme file; ialso had to remove the dataframe from the mutate for local_datetime because I was piping (that took me a bit to figure out....insert eye roll)


mloa_final <- mloa %>% 
  filter(rel_humid != -99) %>%
  filter(temp_C_2m != -999.9) %>%
  filter(windSpeed_m_s != -999.9) %>%
  mutate(datetime = ymd_hm(paste0(year, "-", month, "-", day, "-", hour24, ":", min), tz = "UTC")) %>% 
  mutate(Local_datetime = with_tz(datetime, tz = "Pacific/Honolulu"))


# plot the data; this kept telling me that Local_datetime did not exists and I finally realized that I forgot to create a new tibble with mutated datetimes....so i named it mloa_final
mloa_final %>% 
mutate(local_month_date = month(Local_datetime, label = TRUE), local_hour_time = hour(Local_datetime)) %>% 
  group_by(local_month_date, local_hour_time) %>% 
  summarize(meantemp_C_2m = mean(temp_C_2m)) %>% 
  ggplot(aes(x = local_month_date,
           y = meantemp_C_2m)) +
  geom_point(aes(col = local_hour_time)) +
  scale_color_fermenter() +
  xlab("Month") +
  ylab("Mean Temperature (degrees C)") +
  theme_dark()

# super pretty! But this took forever!!!! (insert laughter)
