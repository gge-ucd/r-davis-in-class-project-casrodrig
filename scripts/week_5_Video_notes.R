#-------------------------

# Week 5 ----
# Video 1 - Data manipulation Part 2a ----

# this lesson is about conditional statements; basic idea is you are setting conditions for R does certain things; 2 bascic funcitons we will go over; in R and computing in general, conditional statments are when you say if something here happens do this, if something there happens do that, if this condition is satisfied proceed; rather than just running or assigning something, you set conditions under which something runs or is assigned; really powerful bc they allow you to build flexible code in programs so if you encounter a certain data output you can do one thing automatically or if not you can do the other so you can process complicated data, say if for instance if you see one observation coded as this do this and if you see another observation coded as this do the other....poss are endless

library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

# ifelse
# this is conditional where you say if this do that; to understand ifelse function it's better to learn conditionals more broadly first

# R has a built in function, it recogonizes certain words you type as special things as well (examples below)
head(surveys)
if(surveys$year==1977){print('year is 1977')} 
surveys$year==1977
head(surveys$year==1977, 1)

ifelse(test = surveys$year==1977, yes = print('year is 1977'), no = print ('not 1977')) # after the comma it has a conditional yes/no; what do you want to do to satisfy this? if yes = print, if no = print not year 1977; R will itterate through that factor of buions we created and ask if cell in year 1977, it will print what you told it to print for each yes or not

if(surveys$year==1978){print('year is 1977')} else{'other year'}
  #is essentially the no condition in ifelse; if was the yes condition; the way R handles else outside of the ifelse function, R recognizes it, but since we alrady printed the ifelse we can just use the squiggly brackets; we get the same warning that we did with just the if satement bc it's not built for a vector; this is the long form, but ifelse collapses that for us, there is still a loop inbedded in that function somewhere but it's encoded in faster programming (like C++ or something), if you are doing a large operation it's very fast to use ifelse vs building your own for each item in this vector 

# essentially what is happening in the ifelse function is that R is combining those two special characters and putting it all within a very nice function; the if command can set up T/F conditions ; when you call head on surveys we can choose something--year 1977; at the back end of the if statment you have to say what to do with that thing that is TRUE, so if that surveys data in column year is 1977, what do you want to do, let's say print; if we simply run that, what happens now is that R will run that and run year is 1977 once and gives a warning message, condition has length > 1 and only the first element will be used (mine has an error message and only has the condition has length > 1) and it's telling us that the if spedial conditional is not a vector wise operation, so what it did was looking for one value and asked...is this value T/F and printed, but we fed in a whole vector we can view this if you just use surveys$year==1977; it only printed the first obervation (check it with head(surveys$year==1977, 1)) and returns True; think about how to build some sort of loops, you would want to irriate to cycle through every observation in the that function to ask if each cell is 1997 and print some result; this is why the ifelse function is so powerful bc it vectorizes that operation on it's own... cool!
  

# lets test the ifelse out on the vector for lecture materials; this is to group animals between small and big by saying the gap for small and big is a hindfoot length of 29.29, what we will say is "ifelse, the test is in the data column hindfoot_cat that is less than 29.29, if that is satisfied, the value observed is less than that number, return the chr string small, if it is not satisfied, then return the chr string big (so you don't have to put in yes = or no =; just remember to put the , ); some are returned NA values where no number is observed
ifelse(surveys$hindfoot_length < 29.29, "small", "big")
surveys$hindfoot_cat <- ifelse(surveys$hindfoot_length < 29.29, "small", "big")
head(surveys$hindfoot_cat) # here we see a bunch of NA values
table(surveys$hindfoot_cat) # do tables and you can see how many big and small there are

# the ifelse works well if you have two categories, like small and big, but lets say you had a bunch of of different categories, the alternative would be to actually nest a bunch of ifesle calls, like
ifelse(test, actionA, ifelse(test, actionB, ifelse(test, actionC))) # can get easy to lose track of things in this, so tidyverse has a fuction called case_when that essentially allows you to nest a bunch of ifelse calls


# case_when
# we will use our pipe function; and then mutate to create a new categorie called hindfoot_cat (just overrite the one we made), we will use the case_when function and have as many condition as we need; we will say if hindfoot_length is greater than 29.29 then ~ ..., seems to work and it created a bunch of big and small values; what is going on with the TRUE, (?case_when is a two set of two-sided formulas is on either side of the ~, we fed in a bunch of formulas around it, left side decides which values match this case and right side provides the replacement value, the starwars one is similar ours bc categorical varibles for the examples, essentially what this shows is writeup for the function isn't clear so explained here, the help file doesn't help much)...his explanation of this: the TRUE seems confusing bc we said hindfoot_lenght is greater than a #, if that's ture code as big, the next statement says TRUE then small, but this doesnt' seem right...what is going on....the last true is shorthand for any other value, so if hindfoot_lenght is greater than # big and saying if anything else is TRUE, code as small; it is actually a catchall, so say you had 20 diff spp and wanted to grab a couple and group all bears, so you are saying if black bear then bear if grizzy bear then bear...so instead you would say if black, bear.....then TRUE ~ so you don't have to specify everything else, rather than typing out everything else; so it's just say TRUE for the rest
surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 29.29 ~ "big", TRUE ~ "small"
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  head()

# prove you can do the ~TRUE with something else; build a conditional in the middle of it; what this says is if it's greater than 29.29 then big, if less than 10 really small, and then everything else small
surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 38 ~ "big", 
    hindfoot_length < 29 ~ "really small",
    TRUE ~ "small"
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  head()

# we have this suboptimal value where NAs were recorded as small, bc the last TRUE is the catchall, where anything else is TRUE return small; now lets build in a conditional where instead of having NAs fall into the anything else bin, we code them as NAs; this is a special operater, first case is the same, but the second is a test for is.na, what we want to return is the NA_character_ as a special thing; doesn't have to be in this order...but sometimes doesn't work when it's put as the last function...just keep it towards the front end 
surveys %>% 
  mutate(hindfoot_cat = case_when(
    hindfoot_length > 29.29 ~ "big",
    is.na(hindfoot_length) ~ NA_character_,
    TRUE ~ "small"
  )) %>% 
  select(hindfoot_length, hindfoot_cat) %>% 
  head()

#group_by(hindfoot_cat) %>% summarise(n()) # just to see if it worked


###################### my group_by is saying there is an erro in group_by(hindfoot_cat) : object 'hindfoot_cat' not found, i don't see any hindfoot_length less than 10 in my data though so it may be that i am using a modified version of surveys, but enven when I change the numbers and view the data it isn't changing hidfoot lengths less than to very small.....hmmmm...i don't know bc i have a column named hindfoot_cat, maybe it needs to be that this whole survey data needs to be named hindfoot_cat??  NOPE...don't know what the hell is going on...guess i will need to ask


# Videos 2 - Data manipulation Part 2b ----

# we will go over joining two datasets with the tidyverse join functions and pivoting or reshaping data, both from wide to long and long to wide

library(tidyverse)
surveys <- read_csv("data/protal_data_joined.csv")


# ---- 1. Joining two (or more) data sets ----

# this is common thing you will want to do; it is often unlikely all of your data will be in one csv file, instead it might be in a diff. csv file per year or you may have supplementary data that you want to append to your existing elsewhere; join funcitons will make your life a lot easier (get in the vibe ;)); to do this we will read in a 2nd csv file stored in the data folder, so we can put the two of them together and demonstrate how this works; to do this we are going to create a new object called tail and read in the from our data folder the tail_length; take a look at tail data from the summary function; it has two columns (record_id and tail_length); to supplement the data we already have about our rodent surveys, we also have one more measurement taken and stored seperately (tail_length), but it is stored alongside the record_id, which is really impt that when you are joining datasets, you want to understand about what it is that R will join on, what is the thing in common; record_id is a shared column in both datasets and you can take a look at this by calling on summary of our surveys object and it's good to comapre if you have all the same values, a minimum of 1 and a maximum of 35548 and same mean and medium, which gives you a sense that these are likely all present in all datasets; even if they weren't these join functions are pretty powerful and there are ways to work around that, but it's good to know what is shared and not shared between the two datasets; the logic of the join function is similar to what you find in a help file, but bc there are many diff. types of joins, the help file looks a bit intimidating and each one has a slightly diff. logic, so we will talk about the basic logic and given what your needs are:

# join_type(first/left data, y = second/right data, by = "column to join by")....this is super helpful

tail <- read_csv("data/tail_length.csv")
summary(tail)
summary(surveys$record_id)

# so let's say we have a scenerio where we want to take the tail data and join that to the surveys data; so we have just one more column; we can call this surveys_join; what we will do is use a left_join; the idea of left_join means is just x, the first data argument you will present R with and the right is the second; you can think of it as x or y, left or right, first or second; what left_join is saying is I am going to start with the x, or the first dataset as my base and then look at second one and join it to the first one; take the left and join it to the left; sometimes it has to do with just column order or priority of what data gets kept/dropped

sureveys_join <- left_join(x = surveys, y = tail) # if you run this w/o a by argument the the default of the join functions are to join by and it will go in and look at whatever column names are shared by the two datasets, this can be helpful or awful, depending on how many columns you have in common and what it is you actually wanting to be joining by; reccomend specifying what column you want to join by; this argument has a default but you override it by with that by argument; there is a whole additional world of joins

surveys_join <- left_join(x = surveys, 
                          y = tail, 
                          by = "record_id")




# ---- 2. Pivoting (or reshaping) data ----

# idea of tidy data and thinking about how important it is to understand the shape of your data, what is meant with tidy data is that typically we shape our data as one observation represents one row; great for analysis and storing your data, but there are times, whether that is wanting diff. kinds of data summaries or relevent when we start visualizing in the next couple weeks about how you want your data to be shaped, and you may find yourself in a situation where you want to change the number of rows and columns based on the summaries you are interested in

# our data is tidy: on row = one observation 
# But we may want to shape the data differently in order to create diff. summary tables (and later this will become relavent with plotting)

#example: goal is to create a summary table and reshape it in a few diff. ways

# Goal: say we want to look at mean weights of each spp. genus in our surveys data, but by the number of plots, so that means we want a table where the genus name is on the lefthand side and the columns are diff. plot numbers with mean weights inside them; compare the diff. mean weight of spp. between or by plots, so this calls on the group_by or summarize function where we will want to create a new object (called surveys_weight) and start with our surveys dataframe and pipe it

surveys_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))# remove NAs and group_by two diff. variables (but can group_by as many objects as you want with just a comma seperating them); summarize with mean weight and give a new name to display on the table (mean_weight = )

surveys_weight # take a look at the output; we have a tibble that is 196 rows long and 3 columns wide; where we the idea of what we want to summarize, we have the genus, plot_id, and mean weight, but if we want to read this in a paper or put it in supplemental material, you typically wouldn't insert something something 196x3; those dimentions aren't very readable, they also don't help us compare anything between plot_id or by genus; what we want to do is reshape this data to make it wider; we want plot_id, each id to be a column using the pivot_wider function here; before we do that we need to think about what pivoted shape do we want in this table; a good way to understand what your data would look like is to look at the unique lengths of the vaious columns we are trying to reshape, so if we next length of the unique values of surveys weight

# reshaping to wide data

length(unique(surveys_weight$genus)) # 10 unique genus -- (make these the # of) rows
length(unique(surveys_weight$plot_id)) # 24 plots ids -- (make these the) columns

# the logic of pivot wider; core essential arguments for pivot: 
# pivot_wider(data,
#           names_from = the single column that has the thing you want to be your new column name #             values_from = the single column that has the values that you want inside your table #             cells)

# in our table the column that represents the thing we want to be our column names here is plot_id bc we want 1-24 to columns; and then the value from columns has the value you want inside your table cells, in this case it's mean weight; the names_from = plot_ is what we want to be wider
weights_wide <-  pivot_wider(data = surveys_weight,
                             names_from = plot_id,
                             values_from = mean_weight)
view(weights_wide)  # we now have a tibble that is 10x25, which makes sense bc we have 24 plot_ids and have a genus column with 25 and only 10 rows, one genus that is represented; in the cells from this values_from, we have our mean weight values; this is a much more readable summary table then the 196X3, so this takes data that is long and pivoting it to a wider format

# we can also do this in reverse, so the pivot-longer function works quite similarly, there is lots of functionality to it, but we will just talk about the core arguments, which are similar with wider, with one longer, which is this column argument:

# the logic of pivot longer; core essential arguments for pivot: 
# pivot_longer(data,
#           cols = the columns you want to stack on top of one another,
#           names_to = the new column name where you want to store the old/wide column names,  #              values_to = the new column name where you want to store the old/wide column values)


# the columns you want to stack on top of one another is where you can selcet many columns, saying I want to take all these columns across all of these columns and pivot them so they are stacked on top of each other and the data will become that long; the names_to argument is a new column name, so you will have to specify w/i "" bc it's a new column that doesn't exist, where you want to store the old (wide) column names (now they are 1-24), tells you what column you want to live in, and then the values_to is the new column name where you want to store the column values, the mean weights; in practice the logic to pivoting and what goes in which argument, it can take practice; the dataframe we just widened we are going to pivot it back to the same size, in theory, that it was before

# the column names (cols) is a bit tricky bc we want cols 1-24, we can select columns numerically (i want the 1st through 24th column or column by name 1-24), but we will come back to this; names_to will be whatever we want to call the names of these columns (1-24) to be, before we called them plot_id; values_to will be whatever the values are to represent this table called mean weight; the 1:24 will throw an error bc we are calling by location and when you do this numerically by location, what we want to call them by location properly or call them by name 
surveys_long <- pivot_longer(data = weights_wide,
                             cols = 1:24,  # calling by location bc its a number, but its starting with genus, genus is actually our first column, but calling by location properly we wouled wnat to say 2:25 bc in our weights wide table, our columns we want to pivot actuqlly start with column 2 and go all the way to 25
                             names_to = "plot_id"
                             values_to = "mean_weight")

          
# calling by location the correct way:
surveys_long <- pivot_longer(data = weights_wide,
                             cols = 2:25, 
                             names_to = "plot_id",
                             values_to = "mean_weight")
# one more way to specify these columns (bc best not to call your columns #'s bc can confuse R and us); call it by name, you can use the same ~ which also has this `` (backtick thing when you dont hold the shift down) R will read one as a column name when you put it in ``                          
surveys_long <- pivot_longer(data = weights_wide,
                             cols = `1`:`24`, # calling by name, using backticks to bypass numbers as column names
                             names_to = "plot_id",
                             values_to = "mean_weight")   

# what does our surveys_long look like: in theory it should look almost exatly like our inital summarized table, but they are slightly different; the long table is 240x3 and the origianl is 196x3, but this is bc when we pivoted wide we added a bunch of NAs into certain plot id columns and when we pivoted back long it actually retained these NA values where there was not weight value for a given combination of plot id and genus, whereas when we summarized, bc we had filtered those out, it immediatly filtered out the NA weights, some ways this is good and bad, but depends...what you want and what your data is telling you, but we have essentially goten back to the shape of the orginal data 
                             
surveys_long                          
surveys_weight                            
                             
                             
