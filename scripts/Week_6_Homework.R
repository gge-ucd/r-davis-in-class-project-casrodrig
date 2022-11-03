# For our week six homework, we are going to be practicing the skills we learned with ggplot during class. You will be happy to know that we are going to be using a brand new data set called gapminder. This data set is looking at statistics for a few different counties including population, GDP per capita, and life expectancy. Download the data using the code below. Remember, this code is looking for a folder called data to put the .csv in, so make sure you have a folder named data, or modify the code to the correct folder name.


## Rows: 1704 Columns: 6
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (2): country, continent
## dbl (4): year, pop, lifeExp, gdpPercap
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
library(tidyverse)
library(ggplot2)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv") 
#ONLY change the "data" part of this path if necessary


# 1. First calculates mean life expectancy on each continent. Then create a plot that shows how life expectancy has changed over time in each continent. Try to do this all in one step using pipes! (aka, try not to create intermediate data frames)

# need to group continent by year to show how life expectancy has changed over time in each continent, can do this by summarizing the mean life expectancy in the summarize function
LifeExp_Time <- gapminder %>% 
  group_by(continent, year) %>% 
  summarize(mean_LE = mean(lifeExp)) %>% #then create a scatterplot and draw a line to show the trend in average life expectancy for each continent
  ggplot() +
  geom_point(aes(x = year, y = mean_LE, color = continent))+
  geom_line(aes(x = year, y = mean_lifeExp, color = continent))

# 2. Look at the following code and answer the following questions. What do you think the scale_x_log10() line of code is achieving? What about the geom_smooth() line of code?

# ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
# geom_point(aes(color = continent), size = .25) + 
 # scale_x_log10() +
 # geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
 # theme_bw()

# scale_x_log10() transforms an axis to a logarithmic scale; Logarithmic scales are useful when the data you are displaying is much less or much more than the rest of the data or when the percentage differences between values are important. You can specify whether to use a logarithmic scale, if the values in the chart cover a very large range; so I am assuming that since the differences in mean life expectancy (just under 10 years to just over 80 years) are larger spanning these 8 decades per the gdp percapita ($1000 to $100,000) makes it look very spread out, using the log10 scale will help us see more clearly the mean life expectancy values between the continents.

# geom_smooth adds a trend line over an existing plot and has grey areas are a zone that covers 95% confidence level [that the values will be within that area]; using this will help show a more realistic trend of what is going on instead of a best fit straght line
  
#  Challenge! Modify the above code to size the points in proportion to the population of the country. Hint: Are you translating data to a visual feature of the plot?
  
#  Hint: There’s no cost to tinkering! Try some code out and see what happens with or without particular elements.
# for the aes we want to define what our x, and y variables are so it will be the columns you want for each in your data set


LifeExp_Time_Themed <- gapminder %>% 
  group_by(continent, year) %>% 
  summarize(mean_LE = mean(lifeExp)) %>%
ggplot(aes(x = gdpPercap, y = lifeExp)) + 
  geom_point(mapping = aes(color = continent, size = 20)) +
  scale_x_log10() +
  geom_smooth(method = 'gam', color = 'pink', linetype = 'solid') +
  theme_grey()


## `geom_smooth()` using formula 'y ~ x'

# 3. Create a boxplot that shows the life expectency for Brazil, China, El Salvador, Niger, and the United States, with the data points in the backgroud using geom_jitter. Label the X and Y axis with “Country” and “Life Expectancy” and title the plot “Life Expectancy of Five Countries”.



countries <- c("Brazil", "China", "El Salvador", "Niger", "United States") # i can make a new vector using the cancatinate functions to select the countries I want in myu data set
gapminder %>% 
  filter(country %in% countries) %>%     # %in% operator in R can be used to identify if an element (e.g., a number) belongs to a vector or dataframe
  ggplot(aes(x = country, y = lifeExp))+
  geom_boxplot() +
  geom_jitter(alpha = 0.6, color = "pink")+  # i made the alpha at 0.6 so I could see my points betrter because I used pink, put jitter here so dots are in the background
  theme_classic() +
  ggtitle("Life Expectancy of Five Countries") + #title the figure
  xlab("Country") + ylab("Life Expectancy") #To set labels for X and Y axes in R plot, call plot() function and along with the data to be plot, pass required string values for the X and Y axes labels to the “xlab” and “ylab” parameters respectively. By default X-axis label is set to “x”, and Y-axis label is set to “y”.











