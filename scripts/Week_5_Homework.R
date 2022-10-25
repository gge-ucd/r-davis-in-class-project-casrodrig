# Week 5 Homework - practicing pivots and conditional statements ----


# 1. Create a tibble named surveys from the portal_data_joined.csv file. Then manipulate surveys to create a new dataframe called surveys_wide with a column for genus and a column named after every plot type, with each of these columns containing the mean hindfoot length of animals in that plot type and genus. So every row has a genus and then a mean hindfoot length value for every plot type. The dataframe should be sorted by values in the Control plot type column. This question will involve quite a few of the functions you’ve used so far, and it may be useful to sketch out the steps to get to the final result.

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

# manipulating surveys data with a column for genus and a column named after every plot type (put cell's names under plot_type); to make each column contain the mean hindfoot lenth with plot type and genus...every row has a genus and than a mean hidfoot length value for every plot type; sort by values in the control plot type column.

# plot_type (cells below contain plot type names going vertical in the first column of dataframe)  genus (contans cell names acroos the topn of dataframe)...all cells filling the dataframe is the hindfoot length...sort by values in the control plot
surveys_wide <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% # remove NAs
  group_by(genus, plot_type) %>%  # group by columns genus and plot_type
  summarise(mean_hindfoot = mean(hindfoot_length)) %>%  # summaraze the data by the means of hindfoot_length
  pivot_wider(names_from = plot_type, values_from = mean_hindfoot) %>%  # make the column headers plot_tpe and the row headers genus (by default), then the mean hindfoot values will be matched with genus and plot_type
  arrange(Control) # this will arrange the mean_hindfoot in ascending order by Control values


# Using the original surveys dataframe, use the two different functions we laid out for conditional statements, ifelse() and case_when(), to calculate a new weight category variable called weight_cat. For this variable, define the rodent weight into three categories, where “small” is less than or equal to the 1st quartile of weight distribution, “medium” is between (but not inclusive) the 1st and 3rd quartile, and “large” is any weight greater than or equal to the 3rd quartile. (Hint: the summary() function on a column summarizes the distribution). For ifelse() and case_when(), compare what happens to the weight values of NA, depending on how you specify your arguments.

summary(surveys$weight) # to figure out (small <= 1st quartile, medium < 3rd quartile but > 1st quartile, and large is >= 3rd quartile)
surveys_cat_weight <- surveys %>% 
  mutate(weight_cat = case_when(
    is.na(weight) ~ NA_character_,
    weight <= 20.00 ~ "small",
    weight > 20.00 & weight < 48.00 ~ "medium",  # finally got it to work! Ok NA_character_ will keep NAs as themseleves and not count them as a categorie we made
    weight >= 48.00 ~ "large"
    ))
 
surveys_cat_weight$weight_cat

# BONUS: How might you soft code the values (i.e. not type them in manually) of the 1st and 3rd quartile into your conditional statements in question 2?
summ <- summary(surveys$weight)
surveys_cat_weight <- surveys %>% 
  mutate(weight_cat = case_when(
    is.na(weight) ~ NA_character_,
    weight >= summ[[2]] ~ "small",
    weight > summ[[2]] & weight < summ[[5]] ~ "medium",    
    weight >= summ[[5]] ~ "large" 
    ))                                                      # I won't lie, I had to look at the code for this...this one was a struggle for me....I didn't think to rename the summary function within the pipe and this code I have is just giving me a bunch of "small" and NA, but no medium or large....I am not sure how to fix this


# in the summary functinon you will see that the first quartile is the 2nd value and the third quartile is the 5th value...index using brackets; oh and you have to use the sum funciton because you have to tell R that you want the data from the 2nd and 5th value in the summary function



