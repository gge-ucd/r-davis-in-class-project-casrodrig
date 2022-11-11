#-------------------------

# Week 7 ----
# Video 1 - Data visualization Part 2a ----

# learning how to visualize your data, customize color, and show data in non visual ways to make it more accessible; on website are resources to checkout and online (Google), plus R graph gallery for figuring out how to plot data depending on type of data you have; generally when we think about data visualization, keep it simple; rx redundant labels, colors that aren't signifying something impt about your data, keeping text clear and concise; think about this as you create a plot; two way to think about how to make plots, are they for you and your exploration...maybe you don't need a whole lot of aes; if they are for communication to show at a conference or paper, it's impt to spend time on how you visualize final plot to make accessible to a wide-range of people, esp color-blind or blind, there are alternative ways to show your data; also impt to show you put in effort to show a plot so others will want to understand your work a bit more (science communication)

library(tidyverse)
library(ggthemes)

# Load plot ----

surveys <- read_csv("data/portal_data_joined.csv") %>% 
  filter(!is.na(weight) & !is.na(hindfoot_length))

# rx NAs from these columns for data visualization; ggplot template and where to specify your data and aes you plot (your x and y or grouping variable), puls a geom func that tells ggplot what type of plot you want (scatterplot, bar plot, etc.:
 # ggplot(data = <DATA>, Mapping = aes(<MAPPINGS>)) + <GEOM_FUNCTION>()

# bring in one of the plots we made last week

ggplot(data = surveys, aes(x = weight, y = hindfoot_length)) +
geom_point()

# basic plot in black and white, no specification to color; lets also do one where we plot by spp_ID, color by spp ID

ggplot(data = surveys, aes(x = weight, y = hindfoot_length, color = species_id)) +
geom_point()

# add a third specification in the aes, color; now ther will be a diff color for each spp ID


# Changing color ----

# what if we want to make the colors more accessible to those who are afflicted with color blindness? There's a a function for that

ggplot(data = surveys, aes(x = weight, y = hindfoot_length, color = species_id)) +
  geom_point() +
  scale_color_colorblind()

# added to the geom_point scale_color_colorblind(); when we run this it has a diff color scheme more accessible to color blindness 

# another way of doing this is with this function called viridis; it changes the color scheme so that how it represents the differences in data would still be captured if it were changed to black and white; this is impt bc many times when publishing a paper, it won't be done in color, so being able to convert it to black and white is impt to show what you want to get across with your data; it also pops color a bit more so it is easier for those with color blindness more; there are two main functions used w/i viridis:

# 1. discrete data

ggplot(data = surveys, aes(x = weight, y = hindfoot_length, color = species_id)) +
  geom_point() +
  scale_color_viridis_d(option = "B")

# scale_color_viridis_d represents discrete, chose discrete bc we have these discrete groups for species_id; there is also an option to change the color scheme, we will choose option B; changes the color scheme from black to yellow


# 2. continuous data

ggplot(data = surveys, aes(x = weight, y = hindfoot_length, color = weight)) +
  geom_point() +
  scale_color_viridis_c(option = "B")

# instead of species_id, use weight, which is a continuous variable, and then also change the d to a c; there is a spectrum from black to yellow; in general best practices for data visualizaiton, there are many, keep in mind to keep it simple and accessible

# Non visual presentation ----

# how to present data in a non visual way; point out that this is a new package for many of us and might not know all functions it provides so you can do BraileR:: and then pull up all the functions it provides

install.packages("BrailleR")
library(BrailleR)

BrailleR::VI(plot)
  
# by typing this out and putting the colons, it tells R to look into the package for a certain function (whatever function you want to use); did not make a plot to put into this so we can just rename the continuous plot and rename it to put the name it to plot (and then add plot as the object above):

plot <- ggplot(data = surveys, aes(x = weight, y = hindfoot_length, color = weight)) +
  geom_point() +
  scale_color_viridis_c(option = "B")

# you run this function and it will give you a text output for your plot and is something you could use, in say, a journal article, in addition to making your plot you can have this represention:
 # This is an untitled chart with no subtitle or caption. It has x-axis 'weight' with labels 0, 100 and 200. It has y-axis 'hindfoot_length' with labels 0, 20, 40 and 60. There is a legend indicating colour is used to show weight, ranging from 4 represented by colour black to 280 shown as colour light greenish yellow. The chart is a set of 30738 points.

# it would be good (if you publish this) to make sure the labels are descriptive and useful

# one other thing to show is how to create a noise to represent your plot; 

install.packages("sonify")
library(sonify)

# sonify reads your data from left to right along the x-asis, and the length of time represents the amount of data, and the pitch of the noise represents the value of your data (lower value = lower pitch)

sonify(surveys$hindfoot_length)

#--------------------------
# Video 2 - Data visualization Part 2b ----

# this video will be about publishing plots, using diff tools called cowplot and plotly which are tools that are used to export plots to diff mediums, say maybe making a mulit-panel figure, sharp enough to send it off to journal or an interactive plot, say an html page and allow people to drag around, point and click and learn more about your data

library(cowplot)
library(tidyverse)

 # now we will use an internal R dataset called diamonds, a pre-loaded basic R dataset for demonstration

diamonds

#this should be an object that is 53000 rows long x 10 columns wide to practice some plots (paste from the course materials)

# make a few plots:

plot.diamonds <- ggplot(diamonds, aes(clarity, fill = cut)) + 
  geom_bar() +
  theme(axis.text.x = element_text(angle=70, vjust=0.5))
plot.diamonds

# we will plot the diamonds clarity values; a trick instead of having to type it out directly you can do a ggplot, or if you imbed that whole call in another set of (), you can do both things at once...it will save it with the new name you gave it (plot.diamonds) and it will print the result of the plot

(plot.diamonds <- ggplot(diamonds, aes(clarity, fill = cut)) + 
  geom_bar() +
  theme(axis.text.x = element_text(angle=70, vjust=0.5)))

#plot.diamonds

# now we will use the cars data set; it has speed and distance two columns
cars
(plot.cars <- ggplot(mpg, aes(x = cty, y = hwy, colour = factor(cyl))) + 
  geom_point(size = 2.5))

# this is a mpg datatable in tidyverse which has car data that has cylinders, manufacturers, miles per gallon, and city and hwy; so we can make a second plot that shows miles per gallon; 8 cylinder stupid truck you have very low gallons per mile vs a 4 banger that has high miles per gallon
#plot.cars

# the last plot is the iris data plot; plotting sepal lenght again petal length...and get a dot plot

(plot.iris <- ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Length, fill=Species)) +
  geom_point(size=3, alpha=0.7, shape=21))

# lets say for some crazy reason you wanted to show all three together; cowplot allows you to do that, not the only way to do that, there are things like grid extra in R you can use, but in general all these plots treat the plot space as some sort of grid for you to customize diff plots in diff spots; simple panels (1, 2, 3, 4...sort of thing), more complex (diff sizes, overlayed over another), gets more difficult the more complex you get; idea is if you can dream up a visulatization, unless it's a pie chart, it's poss to make; so use plot_grid function here, which is a cowplot function and it is for arranging multiple plots into a grid; put all three plot objects into the plot grid and call it panel plot

?plot_grid

#plot.iris

# use plot_grid
(panel_plot <- plot_grid(plot.cars, plot.iris, plot.diamonds, labels=c("A", "B", "C"), ncol=2, nrow = 2))

# the ... in the help file is at the begining instead of the end of the help file and what is going on is those dots are a list of plots that will be arragnge, so what happens when you call plot_grid is the funciton starts working through any plots you give it at the start and then looks through all the other settings you specified and then makes the plot...no matter how many you give it, it will accommodate the plots

# if you read about this panel plot
str(panel_plot)

# tells you have some sort of list object in the text in consil or visual you have panel of plots that are functionally the same thing; store them as one image file; can start to add simple things like labels and columns into that plot grid call, put them after the plot in the call (added on the ncol=2 and nrow=2...run this and we get a 2x2 table specified, and assigend grids A B and C...can call them whatever you want (1,2,3....)


# now lets blow one out to show what it looks like if you want to show diff plots of diff sizes (off the website code called fixed grid plot)

# fix the sizes draw_plot
fixed_gridplot <- ggdraw() + draw_plot(plot.iris, x = 0, y = 0, width = 1, height = 0.5) +
  draw_plot(plot.cars, x=0, y=.5, width=0.5, height = 0.5) +
  draw_plot(plot.diamonds, x=0.5, y=0.5, width=0.5, height = 0.5) + 
  draw_plot_label(label = c("A","B","C"), x = c(0, 0.5, 0), y = c(1, 1, 0.5))

fixed_gridplot

# diff function from ggplot called ggdraw, which is also a cowplot function, to set up a drawing layer on top of a diff plot, means we have a ggplot we are going to throw a bunch of stuff on top of; copy example code and paste your stuff in it bc this is a difficult one to work through; we know we want three plots in this grid, so we will need to call draw_plot three diff times (a new function) which places a plot onto the drawing canvas...you specify that somewhere; in plot land the gird is on a 0-1 scale where 1:1 is in the top right hand corner and 0:0 is bottom left hand corner so you can specify #s w/i that so you can control how things are placed; we want 3 plots of diff widths and heights; the sample code makes two of those grids half width and height and one half grid height and full gird width; it says iris will be anchored at 0:0 point and will be one unit wide, saying the whole grid, height = .5 is half the grid; if we just plot this, it would have a panel that has an empty top layer and a full bottom layer bc we said that we are plotting something half tall and all the way wide; add in the 2nd plot, cars, anchor it at x=0, but we don't want it to plot on top of iris plot, so we want to plot it about half way up where iris stops, so on left side about half way up the grid; should be left hand side half the gird wide by half the grid tall; so if you take the wide call and modify it to 0, R and cowplot took the mpg plot and threw it on top of the iris plot; edit it back, and add third plot, we want diamonds plot to be in upper right hand corner so we need to anchor it half way up and half way over, so x=.5 and y=.5, then we need it to be half the gird high and wide like cars plot, then it looks sharp, and you can add labels on top of them all with draw_plot_label, allows you specify where the labels go and what they say, then you can make it more imformative by naming the A,B,C

(fixed_gridplot <- ggdraw() + draw_plot(plot.iris, x = 0, y = 0, width = 1, height = 0.5) +
  draw_plot(plot.cars, x=0, y=.5, width=0.5, height = 0.5) +
  draw_plot(plot.diamonds, x=0.5, y=0.5, width=0.5, height = 0.5) + 
  draw_plot_label(label = c("MPG data","diamonds data","iris data"), x = c(0, 0.5, 0), y = c(1, 1, 0.5)))

# then titles show up...there are many permutations to this so look them up; it takes a bit to run and view it (iterative process) to get the plot looking like you want; one rule...load ggthemes package; ggtheme plot calls interface with cowplot nicely, might not always behave the way you expect, what happened here is the theme setting acted on the entire cowplot and did not act on individual plots you drew; there are ways to modify this, but always remember to set a theme, but with cowplots it may act in a diff type of way

library(ggthemes)

(fixed_gridplot <- ggdraw() + draw_plot(plot.iris, x = 0, y = 0, width = 1, height = 0.5) +
    draw_plot(plot.cars, x=0, y=.5, width=0.5, height = 0.5) +
    draw_plot(plot.diamonds, x=0.5, y=0.5, width=0.5, height = 0.5) + 
    draw_plot_label(label = c("MPG data","diamonds data","iris data"), x = c(0, 0.5, 0), y = c(1, 1, 0.5))) +
  theme_bw()

# another thing to talk about is how to go about saving the plots; simplest way to save a plot is the ggsave() function; you don't have to set anything, at some point you will want to use settings, but you can simply say I want to save a plot names 'testplot.png', and then I want the test plot to be fixed_gridplot that we just made

ggsave(filename = 'testplot.png', plot = fixed_gridplot)

# the cool thing here is that is that in ggsave it is smart enough to know that you want to create a png file bc you specified by ending it in .png, you could say .tiff, or .jpeg, but .png works and reccomended, so run this and it will be in default setting; what R is doing is it  puts it as a 5x5.95 image and if you go to the files setting in base repo folder, there should be a plot called testplot.png (it is there) it saves it there bc we didn't specify anywhere else for it to go; we could create a folder called figures and then resave the plot as the filename as figures/testplot.png

ggsave(filename = 'figures/testplot.png', plot = fixed_gridplot) # this did not work, showed up with error:Error in grDevices::dev.off() : QuartzBitmap_Output - unable to open file 'figures/testplot.png'; trial and error, so you may have to change the settings w/i ggsave call (say change width and height)

ggsave(filename = 'figures/testplot.png', plot = fixed_gridplot, width = 6, height = 3, units = 'in', dpi = 450)

# 'in' is a character string for inches, set the dots per inch (dpi) and it should look sharp

# I am still getting the same quartz error from before

# last thing we will go over is plotly...interative nonstatic things that are possible

library(plotly)

# use simple iris data set

(plot.iris <- ggplot(data=iris, aes(x=Sepal.Length, y=Petal.Length, fill=Species)) +
    geom_point(size=3, alpha=0.7, shape=21))
plot.iris
plotly::ggplotly(plot.iris) # simiple as that

# ggplotly function converts a ggplot object to a plotly object; end up with an alternate version of that ggplot but it is diff bc it's a live html page where you can hover over the diff points and see the metadata; it tells you what the data says; you can modify it and make it more complex where people can interact in diff ways, like zoom in on diff features; one way to know this is not a normal plot is that it shows up in viewer bc it is generating an html page and not a static plot; if you hover over the piece of paper next to the broom on viewer it opens the plot up on a browser tab and you can play in there



