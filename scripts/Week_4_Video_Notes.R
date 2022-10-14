# Week 4 Video Lecture Notes----

# Video 1 - Data Manipulation Part 1a----

# Learning how to use various packages in Tidyverse

# Set up ----
library(tidyverse)

# we will be going over tidyr and dplyr packages within the tidyverse

# dyplr is nice bc it has a lot of tools for comman data manipulation tasks; like selecting and filtering

# tidyr is nice bc it is good for converting between different data formats that can make polotting and analysis much easier; it's basically a way to reshape your data

# one resource is tidyr and dplyr cheatsheet: https://www.rstudio.com/wp-content/uploads/2015/02/data-wranling-cheatshee.pdf ; good at showing you common functions in these packages and telling you what they do to your data

# Data upload ----
# when you set up your headers with four dashes after them you can click on the top right hand corner box of this r-script and you can click on a header to go to that section (cool!)
surveys_t <- read_csv(file = "data/portal_data_joined.csv")      # we use read_csv instead of read.csv bc we are working in the Tidyverse
head(surveys_t)

# first function we will learn from the dplyr package is select

# Select ----

# we have already been selecting, indexing, and subsetting data, now we will learn the Tidyverse version of doing all of this
select(surveys_t) # it showes that we have all these rows of data, but we have not specified any types of columns (output: A tibble: 34,786 × 0)
select(.data = surveys_t, plot_id, species_id, weight) # select is a nice function here bc you can just type in the columns you want
# there are a lot of rows, but tibble is kind of nice bc it follows a similar format we saw earlier and we can see it successfuly selected these three columns we wanted and tells us the data type

# if you want to select this in the head funciton you can so you don't have as many rows returned
head(select(surveys_t, plot_id, species_id, weight))


# now let's go over filter in dplyr package

# Filter ----

#filter works similarly; first argument will be your dataframe (same with select)
filter(surveys_t, year == 1995)
# set double equals is saying year is equal to 1995; it selected all 1995 data

# what if we wanted to select everything but 1995
filter(surveys_t, year != 1995)
# remember as with removing NAs, the ! is like saying select all but or not year

# what if we want to combine both of those together? This is where pipes come into play; pipes are an operator that take this format, %>%

# Pipes ----

# we want to filter and to select, start with naming an object, surveys2; filter out your columns
surveys2 <- select(surveys_t, plot_id, species_id, weight)

# then name another object to sort out all the small weights, surveys_sml
surveys_sml <- filter(surveys_t, weight < 5)

# now we want to combine it so it's all in one spot; what we can do is use the select functinon to call out surveys_sml; 
surveys_2_filterd <- select(surveys_sml, plot_id, species_id, weight)

head(surveys_2_filterd) # we can look at what the results show; we selected weights <5; you are selcting from your filter data

# another way to accomplish this is by nesting the functions

# Nesting; renamed it as second option
surveys_filtered_2 <- select(filter(surveys_t, weight < 5), plot_id, species_id, weight) # we are performing all the functions at the same time in a nested function 
# check it
identical(surveys_2_filterd, surveys_filtered_2)
# the ouput is true so these are identical; so both worked for selcting and filtering out our data

# an aditional way to do this is with pipes; pipes are useful bc they provide a way to do it all in one section of code that you can run together

## Pipe example ----

surveys_filtered_pipe <- surveys_t %>% 
  filter(weight < 5) %>% 
  select(plot_id, species_id, , weight)   

# the way this works is first you need to establish what the itial, orginal dataframe is that you will be pulling data from; then we will put in tis symbol, %>%, couple different shortcuts (command + shift + enter)---this didn't work for me and my ## pipe is not a subheading either??, then we want to filter the data, then we also want to select columns

# check it out
head(surveys_filtered_pipe)
# should look exactly the same as previous dataframe; we took the nested lines for selecting and filtering and combined them; essentially this pipe function (%>%) could be replaced with the word "then", so R sees this as we have the dataframe surveys_t, then I want to filter the data where weight is less than five, then i want to select these columns that came out of the filtering process; bc of this, R is seeing the left side of the pipe as the data coming in and the right side as the function to process that data; so bc of this we no longer have to specify our data frame here, in fact this would throw R off if we were to do this....we would get an error bc it is confusing R
surveys_filtered_pipe <- surveys_t %>% 
  filter(!is.na(hindfoot_length))  

# if you want to continue the arugments having everything specified you could put a ., and then it would work
surveys_filtered_pipe <- surveys_t %>% 
  filter(., weight < 5) %>% 
  select(plot_id, species_id, , weight)  

# sometimes you will have to do this when working with pipe functions, but for now just leave it without this to keep it simple

# verify if it is the same with the others
head(survey_filtered_pipe)
identical(survey_filtered_pipe, surveys_filtered_2)
# returns TRUE! They are the same


#-----------------------------------------------------------------------------------------------

# Video 2 ---- (Data manipulation Part 1b) ----

# first function we will use is mutating; which is creating a new object or variable in your data; now that we know how to select different columns and filter the data based on different conditions, you may want to start actually changing the data itself and this is where mutate comes in

# Mutate ----
str(surveys_t)
# let's look at how are data is setup with our structure function; looking at the data we have a bunch of numeric or continuous variables; let's say we want to make a conversion of one of these columns, weight are measured in grams as the weight of the rodent, so let 's say we wanted to create a new variable that is the weight of the rodent but in kilograms; the basic logic of how we do this is is with vector math, where we can preform mathimatical operations on vectors and columns in dataframes are all just vectors meshed together; so if we look at our weight column in our survey_t and divide it by 1000, that would be the conversion from weight in grams to weight in kilograms
surveys_t$weight/1000
# when we just run this line of code we get the converted ouput, but what we are going to learn to do with mutate is put that directly into our dataframe, so apend a new column into our surveys_t dataframe, let's used the pipes to mutate ourselves a new column of weight in kg
surveys_t %>%     # macs shortcut to get %>%  is command + shift + m
  mutate(weight_kg = weight/1000)        # the way mutate works, you will give new column name (whatever you decide), then give a single equals sign, and then on the righthand side of the equals sign will be our mathematical conversion, or whatever you want to do to an existing column (edit), in order to create this new column on the left; remember with pipes you do not need to specify dataframe

# when you run this code it's hard to tell what happened from just looking at the output; typically when you append a column it will be appeded on the right most side of the dataframe; but you can see in the tibble that we went from 13 columns to 14 columns

# give the new dataframe a new name so you can see the difference with the append; 
surveys2_mutate <- surveys_t %>%     
  mutate(weight_kg = weight/1000) 

surveys2_mutate$weight_kg # now call surveys2_mutate and then find the weights in kg column

# the second function or group of functions is the group by and summarize functions; in addition to mutating we have learned we can also use mathematical functions to summarize our data; for instance if we use the means function we can take the means of one of our columns
mean(surveys_t$weight)
# we get an NA; we can use math functions to get summaries but we need to remove the NAs; we can do this with indexing and subsetting, but there is another way of removing NAs within a function, na.rm = T (True)
mean(surveys_t$weight, na.rm = T)

# we can do sort of the same thing using the tidyverse pipe language and use it to build on this group by concent

# Summarize Function ----

surveys_t %>% 
  summarize(max(weight, na.rm = T))   # summarize is a pretty powerful function but it sort of an outer wrap to some inner commands; it is insdie this function that we can call upon something like a mean or a max, a whole range of mathematical functions can go in here; this should give us the exact same output but in a smaller dataframe where we fed in surveys to summarize and asked for the max weight in our data; often times what we want to know as scientists is not just the overall average or overall max; we want to know different summaries based on particular groupings (i.e., what spp. weighed the most or what year did something weigh the most or what is the difference between sex); all these questions are really common

# this is where we layer in the group by function as a way of combining and maximizing this kind of pipe tidyverse structure to summarize data; lets say we don't just want to find the mean or average weight of our whole dataset, but want to divide it up by sex so we have male and female rodents in our dataset

#surveys_t dataset pipe through but before we summarize we want to tell R what to group by

# name all the different columns we want to group by the average sex by weight; we are saying takes surveys then group by sex and then summarize
surveys_t %>% 
  group_by(sex) %>% 
  summarize(mean(weight, na.rm = T))
# this ouputs 3 vales for sex; F, M, and some of our data has NA for the sex; even though we told R to remove the NAs for weight, it didn't neccessarily strip out the NAs in sex

# we can do different multiple summaries in here, so we may want ot know a whole suite of different summary pieces, so we can calculate them all at once...in this case we could ask in the same summarazie arugment just seperated by a commma, could ask max weight while removing the NAs; it just adds another column to the summary output table

surveys_t %>% 
  group_by(sex) %>% 
  summarize(mean(weight, na.rm = T),
          max(weight, na.rm = T))
# you will notice the column titiles in our tibble summary are wonky, they are exatly what we typed in to summarize which is unattractive, so we can name our columns internally, just like we did with mutate.
  
surveys_t %>% 
  group_by(sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = T),
        max_weight = max(weight, na.rm = T))
# nameing them with the equal sign just makes the output look cleaner and easier to read; we now have mean_weight and max_weight as our titles

# just like we could do multiple summaries at a time, you can also do multiple group bys at a time

# Multiple Group By -----

# just like with summary we seperate it with a comma; say we want to group by sex and species_id
surveys_t %>% 
  group_by(species_id, sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = T))
# this looks wonky, what happened here is we must be missing a lot of data, particarly for some spp., where in some combination, think of every species id by sex combination there is no data at all so we end up with NAs throughout; tough to read so we have a few options; could start by saying let's clean this up by filtering out some of our NAs before making any of our calculations with filters; before we do our group by and summarize add a filter line where we don't want NAs, say in sex and only want to know about the groups that are male and female we can filter out NAs of sex

surveys_t %>% 
  filter(!is.na(sex)) %>% 
  group_by(species_id, sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = T))
# looks much cleaner....we can also what is the smallest or highest mean weight; we can tack on one more function to this pipe; loads of tidyverse functions to work with; but we are going to pipe throught with this arrange function

# Arrange function ----

# arrange will arrange things in a certain order; you have to specify what you want to arrange it by; we will arange by mean weight
surveys_t %>% 
  filter(!is.na(sex)) %>% 
  group_by(species_id, sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = T)) %>% 
  arrange(mean_weight)
# output: it starts with the lowest value, where previously typically R will arrange in alphabetical order by the datasets first column (well at least in tidyverse it will); arrange will allow you to put it in order according to your summary value, the one you are most interested in and makes readability in the consil easier; you can always save it as an object so give it a name
summary_table <- surveys_t %>% 
  filter(!is.na(sex)) %>% 
  group_by(species_id, sex) %>% 
  summarize(mean_weight = mean(weight, na.rm = T)) %>% 
  arrange(mean_weight)
# you can open it up then from your global environment by clicking on it and visualize it better










