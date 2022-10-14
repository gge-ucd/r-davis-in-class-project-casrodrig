#devtools::install_github("tylerandrewscott/ngRok")
#remotes::install_github("rundel/livecode")

id <- ngRok::livestream_start(port = 8080,
                              hostname = "www.rdaviscode.com",
                              password = 'nifflers',
                              user = 'rdavis', scheme = 'http')
















#Load your survey data frame with the read.csv() function.
library(readr)
portal_data_joined <- read_csv("data/portal_data_joined.csv")
View(portal_data_joined)

#Create a new data frame called surveys_base with only the species_id, the weight, and the plot_type columns. Have this data frame only be the first 5,000 rows.


#Convert both species_id and plot_type to factors.


#Remove all rows where there is an NA in the weight column.


#Explore these variables and try to explain why a factor is different from a character. Why might we want to use factors? Can you think of any examples?


#CHALLENGE: Create a second data frame called challenge_base that only consists of individuals from your surveys_base data frame with weights greater than 150g.

# Resources ----
#examples of what you can do here:
#https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf
# also, if you want to read more about what we are learning this week go to:
#https://gge-ucd.github.io/R-DAVIS/lesson_06_data_manipulation_pt1.html


# Set up----
library(tidyverse)

# Data upload ----
read_csv("data/portal_data_joined.csv")

head(surveys)
head(surveys_t)
class(surveys_t)

# Select ----
surveys_t["plot_id", "species_id", "weight"]
select(surveys_t, plot_id, species_id, weight)

# Filter ----
surveys_1 <- surveys_t[surveys_t$year == 1995,]
surveys_2 <- filter(surveys_t, year == 1995)
identical(surveys_1, surveys_2)
all(surveys_1 == surveys_2, na.rm = TRUE)

class(surveys_1)
class(surveys_2)
identical(surveys_1, surveys_2)

# Combine Select and Filter ----

surveys2 <- surveys_t %>% 
  filter(year == 1995) %>% 
  select(plot_id, species_id, , weight, year)  

head(surveys2)

# Challenge ----
#Using pipes, subset the surveys data to include individuals collected before 1995 or after 2000 and retain only the columns year, sex, and weight. Name this data frame surveys_challenge.
colnames(surveys_t)
surveys_t %>% 
  mutate(weight_length_ratio = weight)


colnames(surveys_t)
surveys_t <- surveys_t %>%
  mutate(weight_length_ratio = weight/hindfoot_length)
str(surveys_t)
# omitting NA: na.omit and complete.cases can be more powerful than you think
nrow(surveys_t)
surveys_omit <- surveys_t %>%
  na.omit()
nrow(surveys_omit)

surveys_filter <- surveys_t %>%
  filter(!is.na(hindfoot_length))
nrow(surveys_filter)

surveys_summary <- surveys_t %>% 
  group_by(species_id) %>% # group by characters, not numerics
  summarize(max(hindfoot_length))


surveys_challenge <- surveys_t %>% 
  filter(!is.na(weight)) %>% 
  group_by(year) %>% 
  select(year, weight) %>% 
summarize(weight_g = max(weight)) %>% 
mutate(weight_kg = weight_g/1000) 
surveys_challenge


surveys_challenge <- surveys_t %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000) %>% 
  group_by(year) %>% 
  summarize(weight = max(weight), weight_kg = max(weight_kg))
  
surveys_challenge


# Extra challenge:
# how to filter for weight < 5?
# how can we test if it filtered correctly?