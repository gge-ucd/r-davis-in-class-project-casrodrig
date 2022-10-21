#By now you should be in the rhythm of pulling from your git repository and then creating new homework script. This week the homework will review data manipulation in the tidyverse.
library(tidyverse)
#Create a tibble named surveys from the portal_data_joined.csv file.
surveys_hw4 <- read_csv(file = "data/portal_data_joined.csv")

#Subset surveys using Tidyverse methods to keep rows with weight between 30 and 60, and print out the first 6 rows.
surveys_hw4 %>% 
  filter(weight > 30 & weight < 60)
 
head(surveys_hw4)


#Create a new tibble showing the maximum weight for each species + sex combination and name it biggest_critters. Sort the tibble to take a look at the biggest and smallest species + sex combinations. HINT: it’s easier to calculate max if there are no NAs in the dataframe…

biggest_critters <- surveys_hw4 %>% 
  filter(!is.na(sex)) %>%   # sex got rid of most of the NAs, but I had to use the na.rm function in summarize to remove NAs from weight
  group_by(species_id, sex) %>% 
  summarize(max_weight = max(weight, na.rm = T)) %>%   # I am still getting a -Inf warning message for this for the first male species weight, I don't remember how to resolve this
  arrange(desc(max_weight)) # desc function arranges the data in descending order of max_weight (larger to smaller)


#Try to figure out where the NA weights are concentrated in the data- is there a particular species, taxa, plot, or whatever, where there are lots of NA values? There isn’t necessarily a right or wrong answer here, but manipulate surveys a few different ways to explore this. Maybe use tally and arrange here.

#colsums will show you how many NAs you have for each variable
colSums(is.na(surveys))/nrow(surveys)

surveys %>% 
  filter(is.na(weight)) %>%  
  group_by(sex) %>% 
  tally() %>% 
  arrange(desc(n))           # desc is a function to arrange sex in descending order

surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(plot_id) %>% 
  tally() %>% 
  arrange(desc(n))

surveys %>% 
  filter(is.na(weight)) %>% 
  group_by(year) %>% 
  tally() %>%                   
  arrange(desc(n))         # tally is a convenient wrapper for summarise that will either call n or sum(n) depending on whether you're tallying for the first time, or re-tallying.

#Take surveys, remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination to the full surveys dataframe. Then get rid of all the columns except for species, sex, weight, and your new average weight column. Save this tibble as surveys_avg_weight.

surveys_avg_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% 
  mutate(avg_weight = mean(weight)) %>% 
  select(species_id, sex, weight, avg_weight)

surveys_avg_weight

#Take surveys_avg_weight and add a new column called above_average that contains logical values stating whether or not a row’s weight is above average for its species+sex combination (recall the new column we made for this tibble).

surveys_above_avg_weight <- surveys_avg_weight %>% 
  mutate(above_average = weight > avg_weight)


surveys_above_avg_weight

