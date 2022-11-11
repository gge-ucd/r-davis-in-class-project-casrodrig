library(ngRok)
host <- 'www.rdaviscode.com'
psswd <- 'nifflers'
user <- 'rdavis'
id <- ngRok::livestream_start(hostname = host,password = psswd,user = user,port = 8080)
view(surveys)
#livestream_stop(id)

# Pivot functions ----
## pivot_wider(data, names_from = the column that has what will become the new column names,
##                   values_from = the column that has the values to fill out the cells)
## pivot_longer(data, cols = columns to lengthen (i.e. take all these and stack them),
##                    names_to = create a new column name to call the column
##                                 names from the columns in the cols argument,
##                    values_to = create a new column name to call the values in
##                                the columns from the columns in the cols argument


# Join functions join diff datasets together; joining two csv files together (hopefully they are clean datasets); list of joins functions (maybe 8 of them); we will work on left joiing and right joining (we are using really clean 1:1 datasets, real world, our datasets will not be this way)


surveysNL <- filter(surveys, species_id == "NL") 

surveysNL_tail_left <- left_join(surveysNL, tail_length, by = "record_id")

#----

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

# Join functions -----
## join_function(x = data1(left), y = data2 (right), by = join column)
tail <- read_csv("data/tail_length.csv")
# tidyverse way
surveysNL <- filter(surveys, species_id == "NL")
# base R way
surveysNL <- surveys[surveys$species_id == "NL",]
# combings logic -- sometimes this works and other it doesn't
# this does not
#surveysNL <- filter(surveys$species_id == "NL")

surveysNL_tail_left <- left_join(surveysNL, tail, by = "record_id")
nrow(surveysNL_tail_left) # has the length of surveys data
# Why? tails is appended to 'master', which we said is left
surveysNL_tail_right <- right_join(surveysNL, tail, by = "record_id")
nrow(surveysNL_tail_right)
head(surveysNL_tail_right)



# Pivot functions ---- (reshaping data)
## pivot_wider(data, names_from = the column that has what will become the new column names,
##                   values_from = the column that has the values to fill out the cells)
## pivot_longer(data, cols = columns to lengthen (i.e. take all these and stack them),
##                    names_to = create a new column name to call the column
##                                 names from the columns in the cols argument,
##                    values_to = create a new column name to call the values in
##                                the columns from the columns in the cols argument 
 
# count genus up by year and plot_id

group_by(surveys, year, plot_id) %>% 
  summarize(genus_count = n_distinct(genus)) %>% 
pivot_wider(names_from = year, values_from = genus_count)

#each year is a column, eaxh eoq ia Plot ID and inside the cells are the counds of genera (per plot, per year)



