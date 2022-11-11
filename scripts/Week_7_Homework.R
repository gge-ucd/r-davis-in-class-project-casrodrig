# For week 7, we’re going to be working on 2 critical ggplot skills: recreating a graph from a dataset and googling stuff.

# Our goal will be to make this final graph using the gapminder dataset:

# The x axis labels are all scrunched up because we can’t make the image bigger on the webpage, but if you make it and then zoom it bigger in RStudio it looks much better.

library(tidyverse)
getwd()

gapminder <- read_csv("data/gapminder.csv")

# We’ll touch on some intermediate steps here, since it might take quite a few steps to get from start to finish. Here are some things to note:
  
# 1. To get the population difference between 2002 and 2007 for each country, it would probably be easiest to have a country in each row and a column for 2002 population and a column for 2007 population.


Pop_differences <- gapminder %>%       # create new tibble
  select(country, year, pop, continent) %>%  # use select to put these into columns into the new tibble
  filter(year >= 2000) %>%    # remove the years that are less then 2002 by filtering them out
  pivot_wider(names_from = year, values_from = pop) %>% # pivot_wider to increase the number of columns and decrease the number of rows (so I can add a new column with the differences and get rid of the rows that are not what i need for my tibble); then pull the names from the year column to identify the years as the differences and the values from the population column
  mutate(Pop_Diff_2007_2002 = `2007` - `2002`) #mutate the column by subtracting the year 2002 from 2007 (simple math formula)


# 2. Notice the order of countries within each facet. You’ll have to look up how to order them in this way.
?filter
str(Pop_differences_07_02$continent)
view(Pop_differences_07_02$continent)# the graphs presented only show Africa, Americas, Asia, and Europe; so I will need to get rid of Oceania; so filter out Oceania 

filter(Pop_differences_07_02, continent == "Africa", "Americas", "Asia", "Europe")

# 3. Also look at how the axes are different for each facet. Try looking through ?facet_wrap to see if you can figure this one out.

?facet_wrap
# to make a one-sided formula with nothing on the left side so put ~continent; a times series panel for each species; scales = "free" allows it to adjust for each figure; Should scales be fixed ("fixed", the default), free ("free"), or free in one dimension ("free_x", "free_y")?; we want our x and y to be free from 1D so that we can see the patterns more easy w/i each panel...but this can make it harder to compare across panels (so within each continent graph we will be able to see the patterns for changes to the population numbers for each country)
facet_wrap(~continent, scales = "free")

# 4. The color scale is different from the default- feel free to try out other color scales, just don’t use the defaults!

?geom_bar
?reorder
# The "default" method for reorder treats its first argument in the ggplot as a categorical variable, and reorders its levels based on the values of a second variable, usually numeric; this will allow the bars in the graph to put them in order from lowest pop diff to higher pop diff; you have to make sure you identify the second variable wich is the y = the numerical variable
ggplot(aes(x = reorder(country, Pop_differences_07_02), y = Pop_differences_07_02)) +
  geom_col(aes(fill = continent)) # we want the bar chart to represent the changes in the population between 2002 and 2007 for each country to be plotted for each continent; so since we want the graph to represent the values in the data we use geom_col; we want to fill the data for each continent so we put fill = continent within the aesthetics; 
# 5. The theme here is different from the default in a few ways, again, feel free to play around with other non-default themes.

theme_classic()

# 6. The axis labels are rotated! Here’s a hint: angle = 45, hjust = 1. It’s up to you (and Google) to figure out where this code goes!
?axis
# have to go goole it; according to datavizpry.com the axis.text.x is a way to rotate the x-axis text labels as an agrument for theme function argument and specify element_text(angle = the degree), but when you do this the labels can overlap with the plot, so you can use hjust argument to fix this; 
theme(axis.text.x = element_text(angle = 45, hjust = 1, legend.position = "none")
  
# 7. Is there a legend on this plot?

# no there is not a legend; according to statisticsglobe.com you can remove all of the legends by placing an argument within theme stating legend.position = "none"
  
#  This lesson should illustrate a key reality of making plots in R, one that applies as much to experts as beginners: 10% of your effort gets the plot 90% right, and 90% of the effort is getting the plot perfect. ggplot is incredibly powerful for exploratory analysis, as you can get a good plot with only a few lines of code. It’s also extremely flexible, allowing you to tweak nearly everything about a plot to get a highly polished final product, but these little tweaks can take a lot of time to figure out!
  
#  So if you spend most of your time on this lesson googling stuff, you’re not alone!
?filter


# Now put it all together

# the continent == was not working for the filter, but was able to use != to exclude "Oceania"
pop_diff <- gapminder %>% 
  select(country, year, pop, continent) %>% 
  filter(year >= 2002) %>% 
  pivot_wider(names_from = year, values_from = pop) %>% 
  mutate(diff_02_07 = `2007` - `2002`)

pop_diff%>% 
  filter(continent != "Oceania") %>% 
  ggplot(aes(x = reorder(country, diff_02_07), y = diff_02_07)) +
  geom_col(aes(fill = continent)) +
  facet_wrap(~continent, scales = "free") +
  theme_grey() +
  scale_fill_brewer(palette = "RdGy") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), 
        legend.position = "none") +
  xlab("Country") +
  ylab("Differences in Population Size Between 2002 and 2007")

?scale_fill_brewer

