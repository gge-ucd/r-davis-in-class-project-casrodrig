# Week 6 Video Notes ----
# Data visualization Part 1a ----

# We will start visualizing, particularly by using a package in the tidyverse called ggplot; the goals today are to introduce ggplot packages and it's syntax; use some examples of scatterplots and boxplots

# reminder...can check where you are working from with getwd()
getwd()

# load tyidyverse and ggplot package is within it; read data in and filter out some of the NAs to help with visualization (not good practice to do if you are just exploring the data....this is just to make it easier for visual purposes); can pipe straight from csv into the filter...using conditions...want to use filter bc we are taking away some rows

# general format of what ggplot syntax is (below):
## ggplot(data = <DATA>, mapping = aes(<MAPPING>) +
##      <GEOM_Function>)
### explanation: typically we open up a ggplot function, and that fucntion has two main arguments: data and mapping functions so data = <DATA> (anything in carets is what will be plugged in) and then mapping function leads to another function, asthetics function where we insert our mappings mapping = ...; then use a + which in ggplot syntax is pretty unique, very atypical, we have used the pipe to move through a sequence of functions up to the point, but in ggplot the + has this effect of layering different attributes onto a plot; then the <GEOM_FUNCTION> is the third essential piece, these are the shape of the data (do you want a scatterplot, boxplot, barplot...pretty endless, you pick one to be the foundation of your plots and build from there)
library(tidyverse)

surveys <- read_csv("data/portal_data_joined.csv") %>% 
  filter(!is.na(weight) & !is.na(hindfoot_length))
surveys
# first we want to start with a blank canvas to demonstrate how a ggplot works

ggplot(data = surveys) # input your data, and what happens on this line of code, R should automatically toggle over to the plots tab; if you have an issue where your plots are jumping out, it's ok but you can fix it; this gives you the base of your plot...you can tell it's starting to do something, but there is no real info in the plot yet bc we haven't told it what info to take, only what data to take; we tell it what to add to ggplot by laying out our asthetics

# add aes for 'mapping coordinates' (a way to think about it but it also takes more than coordinate arguments); basic aes you will need is going to be an x and y; every GEOM requires diff aes, so you have to get use to which aes is needed for each GEOM, but typically an x and y is a good place to start; this is just defining your axes; in this case, think about what GEOM we have before defining axes; talk to three GEOMs today, all have similar syntax, which is GEOM_ , so if you start that you can see the big list of GEOMs in the ggplot package, but GEOM_point is for scatterplots and GEOM_boxplot are for boxplots, etc...In choosing your GEOM you want to think about what kind of variable do I want plotted...envision the figure you want and work backwards, what is my axes, what kind of data are on these axes; first start with GEOM_points and continuous variables, and then we can do step two, both continuous and categorical variables; so here we are plotting something that is continuous by continuous, so do this with the two continuous variable we filtered the NAs out for; in tidyverse language we already specified what the data is surveys so we do not need to call on this column name with any kind of indexing method; can just state the name
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length))

 # now we have gone from our blank canvas; then we layered on aes, weight as x-axis, hindfoot_length as our y-axis, but we haven't filled it with anything, we have given it the map and aes mappings, but not the shape, which is the GEOM, so lets add one more layer for the GEOM; here is where we will add our +, Liza typically spaces down after a +, just as with a pipe, for readability; you could leave nothing inside the GEOM and when plotted we get a scatterplot 
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point()
# I got a blank map still and a warning message that says: Removed 700 rows containing missing values (geom_point)...hmmmm....need to ask about this

# the cool think about this + and layering concept is that you can save bits and pieces of the plot as objects and then layer on from there so you don't have to keep repeating the same long text over and over; for instance if I name this and assign it to an object, in the environment it will save it as a large ggplot
base_plot <- ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) +
geom_point()

# and then print the plot (base_plot) and then can use + to layer pieces onto this; lets make the base plot without GEOM
base_plot <- ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length))

# then what we can do is layer GEOMs onto base_plot and play with it from there and add plot elements; talk about transparency = alpha, color = color, and infill = fill; one of the things you will notice about this plot is it looks like a big mass of dots and cannot really see the dots; there are lots of diff ways you can tweak the asthestics of your plot; can do these in a few places, we will put them inside geom_point() and these arguments are going to be alpha, color, fill arguments
base_plot +
  geom_point(alpha = 0.5)
# if we add alpha argument inside, it is a numerica value that will tell you a bit about transparency, if we put in 0.5, we start to see more see-through dots, telling us where more points are aggregated; if you put in .1 it becomes more transparent...if you are closer to 1 it becomes less transparent (instead of 0.5)...transparency helps with visibility; but we can also add more attributes (next area) by seperating with a comma

#################### MINE IS STILL NOT SHOWING ANY POINTS...STILL GETTING WARNING MESSAGE TELLING ME R HAS RX 700 ROWS...I WILL TRY TO LOOK THIS UP BUT LORT WHAT IS GOING ON

# now specify a color; you won't be able to memorize all the options for ggplot...you can google the different ones, but alpha, color, and fill are the most common arguments; there are a set of colors that R knows, like blue, it does know, but does not know all the colors are, just some, but you can also give it a hex code and find any color you want; but instead of giving it a color (the color argument fills in the dots with the color), but if you instead use fill you have no impact, it differs between the different kinds of GEOMs you use; but here are some basic arguments you might want to use 
base_plot +
  geom_point(alpha = 0.2, color = "tomato")
base_plot +
  geom_point(alpha = 0.2, fill = "tomato")


####  HA! I figured out why my dots weren't showing up....turns out I forgot to add the ! in front of is.na(weight)...onward

# we can also color or use the different attributes based on the data itself, not just red or blue, but what if I want spp 1 to = blue and spp 2 to = red; this is where plotting gets fun, but confusing for what goes in what part of the argument
base_plot +
  geom_point() # instead of saying just blue, we want to be to put a spp as blue, intution might say color = spp_id, but what happens is R looks in list of colors and it doesn't know what to do with this....somethign special you have to do here that brings us back to the 2nd part of ggplot we learned, which is using our aes mappings when we want to specify something about the plot that has something to do with the data itself...so when you want to do this, you have to wrap things like color inside the aes function...not only can we use that aes function inside the ggplot function but we can also use the mapping funciton inside any GEOM and do our mapping = aes and then here if we put something inside aes, you are calling on a point of the data to specify about the data...add this element....what we have done is R has picked a default color scheme and given each of our unique species id a color, given us a legend, and mapped it
base_plot +
  geom_point(mapping = aes(color = species_id)) 

# to include info about data, must be inside aesthetic mapping


# last thing to talk about is geom_boxplot; this is a categorical by continuous; if you tried to do a boxplot with just two cont. data points it wouldn't make sense; so species_id will be categorical on the x-axis; if we want a boxplot that looks at the distribution of weight by spp. you can imagine spp_id on x-axis where each spp id has a unique boxplot and then the boxplot spans on the y-axis the diff weights of the animals
ggplot(data = surveys, mapping = aes(x = species_id, 
                                     y = weight)) + 
  geom_boxplot()

# fill is one of those things that acts diff here it will fill the boxplots with the color
ggplot(data = surveys, mapping = aes(x = species_id, 
                                     y = weight)) + 
  geom_boxplot(fill = "tomato")

# but if you use color = tomato it will outline all the boxplots in the color; subtle differences
ggplot(data = surveys, mapping = aes(x = species_id, 
                                     y = weight)) + 
  geom_boxplot(color = "tomato")

# we can also layer multiple GEOMs on top of each other; so if you want to have a boxplot but also look at kind of a scatterplot spread of the data on top of or behind these boxplots we add a + geom_point(), you get all the points representing our data that would be beter if we layed them behind the boxplot; maybe put them at a very low alpha so they would dissapear potentially; these are still pretty thick
ggplot(data = surveys, mapping = aes(x = species_id, 
                                     y = weight)) + 
  geom_boxplot(fill = "tomato") +
  geom_point(alpha = 0.1)

# what you will realize is the magic of these layers are that the order that you layering them will tell ggplot the order to stack them on top of each other 
ggplot(data = surveys, mapping = aes(x = species_id, 
                                     y = weight)) + 
  geom_point(alpha = 0.1) +
  geom_boxplot(color = "tomato")
  


#------------------------------------------------
# Data Visualization Part 1b ----

# adding two additional steps to visualizing...one time series type plots that will use the same functionality as scatterplots and boxplots but in a slighly different way; then we will talk about faciting; then finally conclude with a quick chat about ggplot themes

library(tidyverse)

surveys_complete <- read_csv("data/portal_data_joined.csv") %>% 
  filter(complete.cases(.))
# when loading we are using filter function and complete.cases function to getting rid of cases where there is NA in the obersvations to build plots; shows dataframe (or tibble) that has about 34 thousand rows and 13 columns for diff variables...rename it

# simple time series -- we will work with years here, if you view (w/ head func.) can learn there are a bunch of diff varibles, which time/month/day/year sampled...maybe do a simple visual, we can count up spp_id by year; (the yearly_count code is how we do it)
head(surveys_complete)

yearly_counts <- surveys_complete %>% 
  count(year, species_id) # says count spp id and year

yearly_counts
# take a look; end up w/ count of each spp_id and year...for instance, year 1977 there were 181 spp

# we can open up ggplot and set data = to yearly counts
ggplot(data = yearly_counts)
yearly_counts

# opens a blank plot window on the screen; you can turn this into any kind of plot but here we will count the of each spp year to year to do change over time; typical for year to be on x-axis instead of y-axis; you could use a ggplot add on function (GEOM) within the aes setting for mapping and make x = year, y = n; run it and you will get a scatter plot where each spp count per year; not neccesarily what we may want but have building blocks for creating a time series plot; here we can see the numbers but can't tell which spp have gone up and down over time

# first thing we may change is GEOM_path, which shows a squiggly line...not helpful, what is happeing here is as far as R is concerned, is we fed in a datatable that has years, spp, and count; you will notice in this code we did not specify anything about spp so what R did is it went row by row and said, what is the year, what's the x-coordinate, what's the count (n)-the y-coordinate, and it simply went line by line, tracing dots from each combination (up and down tracing through lines bc its getting a bunch of observations that have the same x-coordinate for year and diff y-coordinates); clearly, not what we want...lets edit it
ggplot(data = yearly_counts) +
  geom_path(mapping = aes(x = year, y= n))
yearly_counts


# one thing you can do is group within the aes funciton, which is species_id; all this does is tell R when you are creating a path in this ggplot, there should be a unique path for each unique spp_id value

ggplot(data = yearly_counts) +
  geom_path(mapping = aes(x = year, y= n, group = species_id))
yearly_counts

# almost done; now we can add in fun features; we can add color by spp; this won't affect the grouping bc it's the group setting that determines how the actual plot looks; R will give each line a different color; in this case it's not helpful bc there are so many spp, there are 6-7 shades of pink...R is doing the best it can to space out the color pallet...we will learn new pallets to add later...to solve this prob its more complex; you can also do more customization; you can shift where the label is, you can edit the labels, and modify color pallets; one feature to hightlight is say you want points on the path, but wanted each yearly observation to have a point for aesthetic purposes

ggplot(data = yearly_counts) +
  geom_path(mapping = aes(x = year, color = species_id,
                          y= n, group = species_id))


# easiest way to do this is to move the mapping call into the original ggplot call; what this does is sets the same mappings for every geom you call w/i ggplot, so now we are saying whether we call path, or boxplot, or points after this, the x-axis is year, the y-axis is n....don't always want to do this but in this case, this would let us say, geom_path, ...point and run, the colors are the same for the points and the path and you will get the dots in the line w/o having to specify it; this doesn't look great, but showing where you can go from there
ggplot(data = yearly_counts, mapping = aes(x = year, color = 
                                             species_id, y= n, 
                                           group = species_id)) + geom_path() + geom_point()

# Facetting; now facetting isn't specifically a time series thing, but is something useful in time series; ggplot has a function called facet wrap that expands the plot to create a unique grid or pannel for each type of observation you care about; this case we will open a formula; make a one-sided formula with nothing on the left side so put ~species_id; a times series panel for each species
ggplot(data = yearly_counts) +
  geom_path(mapping = aes(x = year, y= n, group = species_id)) +
  facet_wrap(~species_id)
# got a warning so remove group = bc it will specify either way
ggplot(data = yearly_counts) +
  geom_path(mapping = aes(x = year, y= n)) +
  facet_wrap(~species_id)
# you get a diff panel for each spp id and what each panel plots is the particular count and time series for each of the diff animals; shows a couple things, it's super flexible, you can blow it out in all sorts of diff directions, but not very helpful bc the count of some spp is a lot higher than the others and a lot of plots where you can't see much, so there is some hidden functionality, if you type inside the diff wrap function you can see things like scales, for instance, that determines whether every panel in the grid has the exact same scale or not; in this case, lets say we want to keep the same x-scale, the same time series, but wanted to let the y-scale vary by diff spp bc we aren't interested in the raw count we are interested in the trajectory; there is four options for scales (look at them); we just want y to move so we will use scales

ggplot(data = yearly_counts) +
  geom_path(mapping = aes(x = year, y= n)) +
  facet_wrap(~species_id, scales = "free_y")

# in this case you get a lot more trajectory bc the y-axis changes pretty marketley between the diff plots; couple other things to note about facet wraps is you can test what happens if you put species_id on the lefthand side instead of the right (doesn't work on right; examine by rx the ~); so what is up with that formula? the formula allows you to specify two-way grids, so you can imagine a case where each panel is a particular combo of 2 diff factors, it's tolerable but R freaks out (making a seperte grid for each year and each spp, just gonna be a seperate dot); another thing you can do is a seperate function called facet_grid which is a case when you want to be really specific and want to use that x and y combo, facet-wrap is what you typically do when there is only one variable you want to blow out panels for; facet_grid is good for x,y or mulifactor combo you want to generate and also allows you to specify # of rows and # of columns; facet_wrap can do the later also; here is an example
ggplot(data = yearly_counts) +
  geom_path(mapping = aes(x = year, y= n)) +
  facet_grid(~species_id)
# plot shows up and in this case it was one row instead of one column but you could add that you want four columns; but use facet_wrap bc we only have the one-sided, so grid may be exclusive here
ggplot(data = yearly_counts) +
  geom_path(mapping = aes(x = year, y= n)) +
  facet_wrap(~species_id, ncol = 4)
# now you can see you can start to toggle the actual layout, so this is 4 cols, but if you set it to 3 the shape will change a bit (more compressed along the y-axis) 
ggplot(data = yearly_counts) +
  geom_path(mapping = aes(x = year, y= n)) +
  facet_wrap(~species_id, ncol = 3)
# best way to think about this is you can learn 80% of what you need practicing this time series stuff and facet wraps quickly, but the last 20%, about getting colors to look well when you have a lot of groups, about getting scales right, about getting the legend where you want it, and figuring out how to get facet grid to work when you have multiple factors....that stuff tends to get a little more high touch, generally it is the case where you can make your first ggplot for a paper quick and then spend the time making it look more like a high-quality, professional figure; this brings us to themes; one thing to highlight about themes

# themes are an optional feature, but they allow you to quickly adjust multiple things about the plot at once; what themes are are a set of code that essentially have an object that are coded w/ a bunch of plot asthetics all together

ggplot(data = yearly_counts, mapping = aes(x = year, color = 
                                             species_id, y= n, 
                                           group = species_id)) + geom_path() + geom_point() + theme_bw()

# theme_wb is theme black and white; has diff setting other than the base theme; we end up w/ bw undersetting, the colors are not lost that you specified for the diff spp though, just underneath we don't have that classic grey R plot background you can see in the base plot, instead we have the white bottom and then the black and white gridlines; reccomended at very least when you do a plot, do this very simple theme toggle to set it apart and seem less like something you did in your first R class and more like something you put a little time into (but with really no effort)....many diff themes:

# theme_dark (gives a sort of black background); other thing to remember is if you like a particular theme
ggplot(data = yearly_counts, mapping = aes(x = year, color = 
                                             species_id, y= n, 
                                           group = species_id)) + geom_path() + geom_point() + theme_dark()

# but if you don't like something specific about that theme, you can instead of calling the specific theme, call the generic theme object and actually change a setting; say you want to try to make the text really big (20 is super large); when running you can see the text is much bigger, but now you can easily adust it
ggplot(data = yearly_counts, mapping = aes(x = year, color = 
                                             species_id, y= n, 
                                           group = species_id)) + geom_path() + geom_point() + theme(text = element_text(size = 20))

# also some fun themes you can access if you install the ggthemes package; has useful themes for maps and also fun features like you want it to look like a graph in the economist
library(ggthemes)
ggplot(data = yearly_counts, mapping = aes(x = year, color = 
                                             species_id, y= n, 
                                           group = species_id)) + geom_path() + geom_point() + theme_economist()

# or you want it to look like a stata theme, but fun to play w/...lots of options
ggplot(data = yearly_counts, mapping = aes(x = year, color = 
                                             species_id, y= n, 
                                           group = species_id)) + geom_path() + geom_point() + theme_stata()

# wrap-up...times series is fundamentally just a scatterplot that you are drawing lines through, the trick is making sure your are getting the grouping variable correct so you can get the lines between the points you want; we talked about faceting and the facet wrap and the facet grid function; so the facet wrap is when you have one variable you want to have unique for each panel, so you call a one-sided formula with that variable on the right-hand side of the ~ and then ggplot, when you call it, will make a seperate panel for each factor or each character value; facet grid is when you have two combinations, since you want each panel to be a double combination of two unique factor or character values; then we talked about themes, which is sort of high level ways to adjust some of the macro default settings w/i your plot

