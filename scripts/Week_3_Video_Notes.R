#Week 3 Video Notes-------------------------

# How R thinks about data (Part 3, vector math)--first video

# one last command that shows up in the indexing and subsetting section from part 2---a special character
#function in R where you take a percentage sign % and then in and then another % (%in%)---it's a special function
#that takes some sort of value and then asks "is that value anywhere in this other vector?"
animals <- c("mouse", "rat", "dog", "cat") # animals vector that we made from first two modules
animals
#now we will do is run this code that is for animals vector for and ask R if these values in this other vector that we are comparing against
animals %in% c("rat", "cat", "dog", "duck", "goat")  
# we get four bouion values returned.....F, T, T, T.....visualy you can look at the first animals vector and the 
#second vector we compared it to and see rat is in both, same with cat and dog, but mouse is not, so what has happened
#the special in function has done a loop or iteration and has checked to see if everything in the first vector is in the 
#second vector....


#the primary topic of this section is vector math and recycling
x <- 1:10 # a vector of ten values named x; the colon creates a sequence
x     #vector x

x + 3      #the way R treats this is if you add a number to a vector, it will add the number to every item in the vector
x * 10     #can do the same with multiplication using the * ; vector math is your friend when you are doing simple operations

x + c(3,4)  #be carefule when doing more complex vector operations becasue you can get sequences like this

y <- 100:109  # create a y vector from the number 100 to the number 109
length(x)      #the length of x is 10 
length(y)     #the length of y is 10

x + y               # now we can add two vectors together
cbind(x,y,x+y)      # the easiest way to show what is happening is to create a quick matrix
                    # you can see x and y and then the new vector created by x+y; what R did was take the first element
                    # from each vector and added them together and then the second element...and so on...

z <- 1:2             #here is an example of where it starts to fall apart
str(z)              # we call structure (asking what it is) and is shows it is an integer sequence with 2 values (1 and 2)
x+z                 # x is 10 units long and z is only 2 units long; we get another 10 unit vector the same lenght as x
cbind(x,z, x+z)             # create another vector to see what is going on; R takes z and recyles it as many times as it needs to
                            # until you reach the length of x (first item of x and z, second items are the second iteme in x and z, the third starts z over; it's called vector recycling and it is what R does when you are trying to combine vectors of different lengths)
                            #if you created a 1:3 vector for z instead of 2, you would get an warning bc 10 divide easily by 10...the shorter vector length is not a muliple of the longer vector length

# a couple of other ways we can do recycling; you can also recycle bouions; in this case below we can create a quick vector of the 
#value true and the value false; it's two units long and if we put it within the brackets to the x vector to index x
# it will not just apply t/f to the first and second elements in that vector, R will recycle that as many time as the length of the vector
c(TRUE, FALSE)
x[c(TRUE, FALSE)]

# it will return 5 vlues because 2 goes into 10, 5 times; it returns the odd values for TRUE; if you were to add x[c(TRUE, FALSE, TRUE)], will get weird indexing...don't do it




#-----------------------------------------------------------------

# How R thinks about data (Part 4, missing values)----second video


# dealing with vectors---this one is about missing data, say you have some sort of measures but one of them was not observed
#it was messed up or not recorded; in R the most common way data is recorded as NA values

#create a vector of 4 observed heights with four numbers and one NA value
heights <- c(2,4,4,NA,6)

# now use the mean function to calculate the mean value from all the numbers in that vector
mean(heights)
# but when you run it R will spit out an NA value bc it does not know the value for NA (it will do this for any basic calculator functions)
mean(heights,na.rm = TRUE)   # na.rm is a toggle function that by default is False, which means R leaves the NA in and tryes to calculate it and it breaks
                             # but if you set it to = TRUE, R will kick out all the NAs and calculate the mean of the rest of the values

max(heights, na.rm = T)       # we can do the same thing with a max function
min(heights, na.rm = T)       # same thing with minumum value in the vector

is.na(heights)                # sometimes you want to be able to remove all NA values or want to know how many values or which vales are NA or not
                              # so you will do a function called is.na, what this does is look at the vector and prints out T for when a value is NA and F when it is not

!is.na(heights)               # say you want to flip it around and want to pull the non-NA values, the trues get returned and falses get thrown out
                              #putting an exclamation point in front of it (saying not) will flip it so you get trues where there is not an NA


heights[!is.na(heights)]      # now we can use this strategie to subset out things from the heights vector and get rid of missing values
                              # if we run this it will kick out the NA and leave us with a 4 item subset of just the non-NA values

heights[complete.cases(heights)]      # sometimes you can use a complete cases, which is a function that you can use to look for NA values across the row
                                      # its used for subsetting matrices and dataframes




#--------------------------------------------------

# How R thinks about data (Part 5, not-vectors)---video 3


# this lecture is about other kinds of data besides vectors, quick overview....

# lists ---- they are powerful bc they can contain bags of everything, arbitrary datatypes, you can make a list and store a bunch of numbers in the first itesm and then store a whole page of text
#in the second item, and can make nested lists, like the first item in the list could be a huge dataframe, and then the second
# item in the list could be pages and pages of texts, they are very flexible in that way, but you can't take a list and add it to something
# you are not doing complex operations on a list, they are used to store things and  return values; you can grab things out of it that you need and then can 
# preform calcualations on them; the trick to recognize that you are dealing with a list in R, you will use things like type and class

list(4,5, "rat")   #when you see the output from this with the double brackets and numbers, you are usually dealing with a list
                   # it shows you line by line what items are in the list

my_list <- list(4,letters, "rat")   # a second example shows a vector of all the letters in the alphabet, lists can get very complex real fast
class(my_list)                      #then call class...R tells you it is a list
str(my_list)                        #if you call for the structure, it tells you it's a list that is 3 units long, and the different data type in this entry
                                    #first data type is numeric, then character...
length(my_list)                     # if you call for the length it will tell you it's 3...impt thing to note, since the second item in the list has 23 letters but it doesn't give you how many characters are in that item, it give you the top level number items there are
length(my_list[[2]])                    # if you wanted to grab that second point and wanted to know how many characters there were; index the 2nd item

#next item is a data.frame, functionally the best way to think about this is like taking a vector and sticking it side by side with another vector
my_df <- data.frame(letters)  #use the built in letters object that is in R  shows all the letters
#if we set that into a data frame instead of the vector, in the data.frame it takes on structure with colum and rows, the column is called letters bc that is the name of the object and you can see how many rows are in the data.frame
# you can call it my_df for my dataframe

length(my_df)   #now you can call length on data.frame and it shows it is a length of one....weird...try a different function
dim(my_df)           #dim is short for dimenstions, lenght is actually measuring the number of columns, which is one, dim shows that you have 26 rows and one column

my_df2 <- data.frame(letters, letters)  #you can prove this by creating a new df called my_df2 and feed in letters again
my_df2       #it now has two columns
dim(my_df2)   #now it has two columns
# the other thing to know about a dataframe is you can have different types of columns; you can have letters and numbers, but 
#R will not let you do recycling in a dataframe...you can feed in a single number and it will recycle all the way down (next code line)
data.frame(letters,1)  #but you didn't give it a name for the second column so it called it x1....and then all those valuses will be one and R will recycle it all the way down
# if you name it x = 1 then it will label it that way ..... data.frame(letters, x = 1)


#matrices reseblem the dataframe but they are more bare boned; they have to have all the same type of data in them and you can coherce matrices and dataframes 
#back and forth in R but sometimes get weird resutls; dataframes are meant to store columns of data (more like a spreadsheet) but matrices are 
#more like a mulit-set of columns or observations...so generally if you are storing different variables all in a spreadsheet column type structure you store
#a dsataframe, matrices are more for like math operations or storing a set of values in a 2-D format, might have like a distance matrix (or that fashion)

matrix(nrow = 10, ncol = 10) #if you open up the matrix funciton in R (by pressing tab in the parentheses) it will let you do something like 10 rows and 10 columns
# in this case we didn't feed in any values so it simply printed out a blank NA matrix of 10 rows and 10 columns)

matrix(2, nrow = 10, ncol = 10) # we can put a number in there and in this case bc there is only one value, every # will be 2

matrix(c(2,3), nrow = 10, ncol = 10) # we could feed in a larger vector and in this case R will copy all this until it fills the matrix; 
# there is an important ooption for this function; if you keep hitting comma and then tab, called the byrow function, this tells you should R start filling it by row or column in the matrix


# Array - this is simply a stack of matrices and R has the ability to essentially take a 3-D data storage, think about a matrix as row and column,
# and can stack those on top of each other and then you end up with height as well, so instead, you index the matrix using the brackets with row and column inbetween
# for row and column in a matrix
matrix[,]
# an array will have two columns, we will talk about subsetting arrays later
my_matrix <- matrix(1:10,ncol = 10,nrow = 10) #briefly shows how to subset an array
#here we have created a matrix that is 10 columns wide and 10 rows long, and in this case, each column is 1:10; so if we wanted to selectout the first column
#rows always come before columns
my_matrix[,1] #this will show only the first column bc rows come before columns
#if you wanted to show the first two
my_matrix[,c(1,2)]
#conversley if you put it on the front side of the comma, you will return the first two rows
my_matrix[c(1,2),]
#you can also do both
my_matrix[c(1,2),c(1,2)]
#an array does the complicated version of this, but you can also play in the z space
matrix[x,y,z]

# last thing to talk about is factors, and factors are sort of special bc they are weird
# lets say we have a factor variable and we are going to make a vector of sex, and turn it into a factor
sex <- factor(c("male", "female", "female", "male")) #all we have done here is nested that vector in the factor function
class(sex) # if we call class on that sex object, R will tell you that it is a factor
typeof(sex) # but if we say typeof, which is a function that will tell you what type of data it is, R will say it is an integer
# essentially factors are just integers with character labels on them and so they are not actually charater strings, can have weird behavior

levels(sex) # we may want to see the titles that are assigned to the integers
# in this case if we call the levels function and put the factor variable inside of it, levels will tell you this vector has two different observed values, female and males
nlevels(sex) #simply tells you how many levels there are (2)
str(sex) # if call factor into the structure function it will say hey this is a factor with two levels and here is what they are 
#and then it repeats 

#here is where we get into the integer thing, R says the actual factors here are 2 1 1 2, it's actually viewing the numbers
sex # current order
sex <- factor(sex, levels = c("male", "female"))
sex  # after re-ordering; R is only treating levels as the integers 1 or 2, depending on how many levels you have

as.character(sex)  # if we call as.character on that it looks the same, so you may at first think nothing is happening there but if you run
# the original sex factor in your vector again, it seems like R is treating them differently, there are no quotes around those 
#values, and the as.character string doesn't tell you anything about levels
sex

year_fct <- factor(c(1990, 1983, 1977, 1998, 1990)) # this is where it gets weird; this time lets create a factor with years
# we have this object with years and each is a level; 1990 was repeated so we have five years with four levels
year_fct

# if we call as.numeric on that value, it gives us an unwanted result, bc what it is giving you is the integer that R is using 
# to represent that factor or that that factor is sort of standing in for rather than the actual number, so in this case if you call
# as.numeric on those factors, odds are you may want 1990 to stand out but R will give you the number 3 bc it's saying this is the third integer
# or the third factor, R doesn't know these are real numbers, it just knows integer format to represent some sort of objects 
as.numeric(year_fct)


as.character(year_fct) # on the other hand if you call as.character on that same factor vector, it will return those numbers through a character
# and if you nest that in the as.numeric call it will actually spit out the numbers you want
as.numeric(as.character(year_fct))


as.numeric(as.character(year_fct)) -1 # if you subtract the number 1, coersion will happen; R will take the quotes off and ask "is this thing a number"
# what is going on there in the character string 1990, R will coerce it to be a number and subtract 1 from it
levels(sex)
levels(sex)[1] <- "MALE"   # you can change the levels of a factor by indexing, so levels calls the 2 factor levels
# and if you index with the number 1, it's the first level that you can change the name of it
levels(sex)[1]
levels(sex)  # you can change one, but not both
levels(sex) <- c("MALE", "FEMALE") # you can change both without indexing, feed in a vector of the two new names into that orginal levels call
levels(sex)
# what is essentially happening here is skipping a step....you have a function on the left side that is pulling out the levels of sex
# and then R allows you to retitle the output of that function and edit the original factor


#----------------------------------------------------
  
# Spreadsheet best-practices---video 4
  
# this is not a code lecture, but a spreadsheet discussion, but spreadsheet are the most common way we deal with things in R
# you end up creating some sort of spreadsheet to do your analysis on; the reason is bc when you go to do something like a regression model
# the packages need you to feed in some sort of flat flie, in matrix type format or dataframe, which are just spreadsheets that live within R
# the second reason is the principles of good spreadsheet practices are not limited to spreadsheets, so its a good test case for thinking about these things

# 3 quick objectives for this discussion: tidy data (set of packages within packages called tidyverse, but there are certain principles within it)
# second objective is knowing certain kind of formatting and data entry mistakes to avoid 
# third thing is sort of introducing dates as data

#Formatting
# if you have raw data (say soil samples), you never want to edit directly on the raw data, always make a copy of it just to be sure
# save a new object so you have root data you are working with; if you can use scripted language to do it makes it a lot easier to document your steps
# best research practices you start from those original data and discuss the cleaning, modification, and adjustment steps you made
# doing that in script it kind of does it automatically, if you are pointing and clicking stuff in your spreadsheet you don't have a record of that, 
# you aren't tracking what you are doing in excel so you need to keep some sort of documentation of what you did


# say you have a spreadsheet that isn't your original file, couple things about organizing; each column is going to be some variable, not each row
# this is an important distinction, every once in a while you will find someone who has stored data the opposite way, where each row is a variable and it goes out
# and excel will tolerate that, but if you do that in R you will have a bad time; so always think variables in columns and observations in rows
# seoncd practice within this: each row/column combination only has one value, so we don't want cells where you have stored a couple different things (like one value, second value)
# every cell in your spreadsheet or R dataframe should have one value within it

# a couple of other mistakes is one we don't want the multiple tab thing that excel lets you do, workbook with 12 tabs of spreadsheets stacked on top of each other
# R can handle those, you can read in a particular sheet from a workbook, but it's not good practice...you want a seperate sheet 

# next idea sort of relates to that because excel is robust to crazy workbook behavior...we don't want spread data across multiple tables either; where there are tables all over the spreadsheet
# it's hard for programs that aren't excel to deal with those things; single spreadsheet, not tabs, all info in left top of spreadsheet

# don't record zeros as blanks, 0 is a real value where blanks are an NA....you also want to make sure you are also picking an appropriate null value
# there are many different you can look up (the best practice is NA...R likes it or NULL, a special object in R)
# no colors or fonts on the spreadsheet either

# the visual basics bc everything will get lost...don't store comments with the data, they will dissapear in R; you have to store the comment 
# you have to record the comment in a different column if you want it to show up in R

# keep your actual units in your column name rather than in the actual value, like $, it will read it as a character

# avoid spaces in data names, coloumn names, and file names 

# avoid numbers and special characters in these areas too



# mainly what you want to be thinking about is clear, transparent, and reproducabe research; things that are happening on an excel file on your computer
# are in the exat opposite of that so every step of the way you want to be thinking about a simple, easy, error free, start to my research
# then I or someone else can apply a code and get to the results you want to present; start easy and error free place


# excel does weird things with dates; the important thing to remember is excel will often try and convert everythign to dates and won't tell you
#when it does that and it doesnt always interpret it as you want it, so it tries to take dates and turn it into a more complete date 
# the best rule of thumb here is two things: treat dates as multiple pieces of information, so instead of the date in a column, have the month in a column
# and seperate column for year, and seperate one for day, and time if needed; you can always piece them back together again; second, just try not to let 
# excel handle dates, bc if you just have the month as a column excel doesn't knwo the difference....it will just keep those


#------------------------------------------------------
# Reading in and exploring data---video 5


# Focusing on reading in data; what it means to read your data into R
# Goals:
## Using the read.csv() function to read in data 
## Explore and subset data frames
## Packages and base R vs the tidyverse

# we want to Read in data, and there is one function
read.csv(file = "data/portal_data_joined.csv") #one key argument called file name and it will equal with quotes and you can hit tab to enter it in if you are in the right working directory

# you will want to assign your data to a name
surveys <- read.csv(file = "data/portal_data_joined.csv") 

surveys
#now we have an object that is saved in our global environment called surveys

# inspecting the data, some ways of checking in the data is with n based functions, (nrow and ncol are short for # of rows and # of columns)

nrow(surveys)
ncol(surveys)
# this should match the numbers in your global environment; this gives you a sense of the dimensions of your data

# this is how you ask R what kind of data is surveys; there are two different functions that can tell us a bit about data: class() and 
class(surveys)
# class tells us this is a data.frame, it's tabular data like what an excel spreadsheet looks like; we can open up surveys, but large sets are hard to do this with
# can do this by clicking on the name in the global environment or you can type in the function View(surveys)
# another function for looking at what type of data surveys is thetypeof(surveys), which will give you a higher level output
typeof(surveys)
# there are lots of diff. data types and classes that are heirarchially nested....so a data.frame is a list, which is higher more general category of data types


# looking at the top or bottom of the data, to determine size; the bigger the data is the harder it is to eyeball it and scroll through it; printing it is worse
surveys
#it's long and can freeze R

#often what we use are these heads and tails functions
head(surveys) #this allows you to look at the top of the surveys dataframe; the first six are printed out by default which gives you a snapshot of your data w/o printing it all out
tail(surveys) # this will give you the bottom six; gives you a sense of if your data is all formatted right from top to bottom

?head #optional (say you just want the top 4 or top 10) ; optional arguments inside the head function; there is an n = 6l, but tells you it's an integer vector and asks how long you want it to be and it is at default now
# which is 6...we can do this to get the top 10 observations printed out
head(surveys, n = 10)

# look at the structure and summary so we can know a little bit about how R is reading the data
#the first one str() gives you the structure of each column
str(surveys)
# revising the idea of data types, says it's a data frame and how many obervations there are and columns (variables), then it tells you what those 13 variables are
# by name; $ is indicitive of a column; column name, type of data in column, then lists the type of data they are with the first few are

# summary function will do the same sort of thing but it is more summarized differently; in addition to giving us column by column info., it will also summarize the data by giving 
# the min, max, quartiles, mean, and medium; for integer data, but can't get those for character data; character will just count up how many there are
summary(surveys)


# Indexing, the impt thing about indexing is, is that R is trying to extract a piece or particular part of the data, whether that's from a vector
# or from a data frame; in this case we are extracting data from a 2D dataset and in our 2 dimensions are our rows and columns; it becomes impt bc the way that
# R thinks about extraction will respond to these two arguments about row and about column; not really argument bc indexing bracets are not functions, but it's 
#important to know that inside there is someething like a data frame and when we open up the data frame we do that with those square brackets, telling R I want to go
#inside this data.frame[], w/i those bracets we have to be specific about what goes into them, row on the left, column on the right <- data.frame[row, column]
# so why do you have to subset, like use the concatnate function within subsetting....will review in a moment.....it's bc this comma within the bracets has a particular
# meaning in that it divides the dimensions where the comman inside the cancatnate function has a diff. meaning


surveys[1,1]  # open up the square bracets to tell R that i want something within that dataframe, say row of the first column
#it printed out the specific cell related to row one and column one

# take the first row and sixth column
surveys[1,6] # which is the spp. ID

# indexing has dimensions, but if not specified with a comma it will default to the column dimension...
surveys[6]
# by default it will print out the sixth column, not the sixth row
surveys[,6] #same as this; nothing in any of the dimesnions means erything is returned

# Signs or "operators" for helping us subset
## the colon : represents a range 
## - subtracts
## the concatinate function c() helps us list values in a vetor

surveys[1:6, ] #index rows 1-6 for all the columns; imitating the head function
surveys[-1:6] # this throws an error
surveys[-(1:6),] # say we want to remove the rows 1-6
surveys[-1,]  #removes only row 1

# subsetting by column name; often we do not know our columns by number name...sometimes they move around and we rearrange them
# and rename them; generally you can say I want column 3 
surveys[,3]
# we don't really know what that column is so usually we want to subset column by name
colnames(surveys) # will show you the names of all your columns
#say you want to subset column 3 but do it by name (day)
surveys[,"day"]
# gives the same output as 3 but it's easier to id the ouput and resilient to changing column position

# another common way index (subsetting) by column name is to extract a single column by using the dollar sign; nice bc instead of 
#using these brackets and these 2D things; you can do this instead
surveys$day # R will prompt you with all the column names....pretty handy

# it also helps you avoid typos too!




#-------------------------------------------------

# Tidyverse ----- video 6

# slightly diff. way of reading in data, that can help with some features and we will introduce an idea of tidyverse which is a suite of packages 
# install and load tidyverse
install.packages("tidyverse") # anyone can make functions, then people can download and install them

# you only have to install packages once and R will let you know when you need to update them

# you do have to, each time you open an R session, load the packages you want into your library
library(tidyverse)
# you should get a notification that packages are loaded

# this means we can use the functions from the tidyverse package; you can google what the funcitons do
# an alternative to read.csv
surveys_t <- read_csv(file = "data/portal_data_joined.csv")
# reads a bit different, Tidyverse read_csv reads in data as a "tibble", which is a special dataframe that makes things easier to read

class(surveys_t) #if you use the class function...;there is a lot more than just the surveys object...the surveys_t have special tibble data frames
#it's just easier to read in the output...for example the head function
head(surveys_t)
head(surveys)
# the blanks from surveys will summarize the type of data in the head printout and automatically changes the empty cells to NAs 
# and also calls those to your attention in the tibble
















































  
  
  
  
  





















































