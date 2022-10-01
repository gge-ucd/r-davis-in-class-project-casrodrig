#Intro to R (part 1)

#Environment box shows all the different data frames, objects, functions that you have written in your code; it will populate as you work
#Git box is where you can push and pull into and out of git.com where your repsitories are stored
#Files are important bc it tells where R where files are located and accessible (working directory)
#white rectangle in upper lefthand corner with the dropdown box is a quick way to create a new R script
#R script is the space you will be working in (like this screen right here), it's like a console but it is a way to save your code to use in the future (always save the R Script)

#using different functions in R and the programing language
#arithmetic
1+1
#you can do various functions and in order to run each line of code you can use a keyword shortcut or mac option or command enter to run the code or mannually run it

#comments help you remember why you are doing something the way you are doing it, add a hashtag and you can write whatever you want

#scientific notation, logs, exponentiate
1/600000
log(3)
sqrt(64)

#you can also nest functions (nested functions), so say you want to take the log of sqrt of 4
log(sqrt(4))

#comparisons -- say you are curious if one is equal to one....shows equal is denoted to equal signs; can also ask R if one is greater than -1, etc.
1 == 1
1 > -1
5 >= 8

#helps if you want to see if something matches or does not match


#---------------

#Intro to R (Part 2)
#What makes R an object oriented programing launguage? Also, a few ways to make objects and other features in R Studio

#objects and assignments (an object is a way of describing any value, data, or variable; you are naming a value of interest you can call up later)
x <- 2 #x is equivalent to 2
x
x <- c(1,3,5,6)#a string of numbers associated with the object, could be nice if you are wanting to take the log of all four numbers
log(x)
my_favorite_icecream <- "Chocolate" #can also attach a string and call it whatever you want to 
my_favorite_icecream #(one thing to point out with the object string is that R can complete when you are typing a word out, it will autopopulate it)

#tab completion (completion of what you are typing)
my_favorite_icecream #hit tab as soon as it highlights it and it will complete the functions you need, handy tool


#object naming convention
my_favorite_icecream #try to be consistent with how you name things, use underscores to create no space 
myFavoriteicecream

#R help files
?log #use question marks and what you need help with and it will pull up troublshooting in the help tab
    #scroll down to the bottom of help page and look at the examples because it helps a lot
??log #double ?? can pull up additional information or google it


#arguments to functions
log(3)  #there are various arguments you will place inside a function, so say when you type log, R will populate something showing there are two different arguments that are within this function, a value x and you can also specify a base value
        #this is basically saying x=3 and can you just keep the base=ep(1) as the standard for this function
log(x=3, base=exp(1)) #the argument to the function is x=3 and base=exp(1)
log(3,10) #can also write it shorthand but until you are used to the arguments it's best to write them out


#Errors, warnings, and messages
log(my_favorite_icecream)  #error means R cannot run what you are telling it to run
                           #Error in log(my_favorite_icecream) : non-numeric argument to mathematical function
                           #just telling you that you cannot run the log of something that isn't numeric
log(-2)   #gives a warning message, but code will still run even though there may be a problem associated with it; if it is a problem look into it, assess the warning before moving on

#messages are more informational, R updates things all the time, maybe the way of coding has changed like calling up a function with a different code


#---------------------

#File paths and folder set-up

#most projects have two main files and a readme file; a data file and script file; you can document what you are doing in the readme file
#you can create a new file in your project by click new folder....OR you can code for it with functions
dir.create(path = "scripts")#to create a new folder in R is similar to a directory creation; use the path function to create a new folder; use quotations when naming something new
#it will popuolate as a new file wherever you have your working directory set to
getwd() #this funciton will tell you what working directory you are working out of
"data/portal_data_joined.csv"    #hit quotation marks and hit tab, you can select folders, hit tab again to see what is inside them



#----------------------
#How R Thinks About Data I (vector objects) 

#how you store info. in R and how it processes the info you loaded and how it creates code, how we organize stuff to preform operations
#the basic functionality for storing stuff in R is a vector which is a collections of items that could be numbers, strings, you could meake a vector named weight
weight <- c(50,62,43,45)  #we just created an object called weight and store the object, what is inside is are the numbers we want to concatnate
weight  #it created a vector called weight that has four items, four numbers we specified
animals <- c('dog','rat', 'cat', 'armadillo') #we created a vector of four animal names, doesn't have to be multple
animals

year <- 2022  #can do year with one entry
year

#the next step after you created a vector is figuring out how to analyze it in more detail, we are often not dealing with small datasets, you want to understand what the vector is without printing a whole giant dataset on your screen
#basic functions for "go to vectors"
lenght(year) #length tells you how long the vector is
length(animals)
empty_vector <- vector()
length(empty_vector)

#class is a function that tells you what type of vector you are working with
class(weight) #tells you it is a numeric vector, has a set of numbers within itit
class(animals) #tells you it is a character vector, it's letters, string values, words are character vectors

#str function, what it does is if you feed your vector into str it prints out the details of it without printing the whole thing to screen
str(animals) #it says chr (character class) 1:4, which means its a character class that is four units long, but since it's short it printed it all out

str(weight) #it says num (number class) that is 4 numbers long


#c function for catcatnate
c(weight, 63) #original weight and then add an additional number
weight <- c(weight, 63) #this will overwrite the orignal weight and tell you it is 5 numbers long 1:5 instead of 1:4
str(weight)

c(weight, animals) #you can also concatanate numbers and characters; R turns all of them into string variable
new_vector <- c(weight, animals)  #new vector will be a character vector bc R doesn't want to lose information, it's easier to turn a number into a string, if you tried to take dog and turn it into a number you would prob get an output that says NA....strings just help you keep input
class(new_vector)       #returns this string as a character, you are coercing the information into a string so you don't lose information
c(weight, TRUE) #if you combine weight value with a bouioun, it converts the bouion into 1


#R also have buvioun values (T/F), functions much like 0's and 1's
TRUE-1 #equals 0
FALSE-1  #-1

#storing in R--R can also use integer values, 1, 2, 3, 4....if you had large data and no decimals or noninteger numbers


#------------------------------

#How R Thinks About Data II (subsetting and indexing vectors)


#We talked about combining things to vectors with the concatanate function, but sometimes you want to pull things out of the vector

animals <- c("mouse", "rat","dog","cat")
str(animals)

#there are a couple different things you can do to subset, R is really good about thinking about the location of objects within a vector (you can use any #using the particular location of an itemin a vector to pull it out)
animals[2] #you use brackets tells R we are indexing, pulling out an item that belongs to a particular location
animals[c(1,2)]  #if you want to pull out multiple values you have to create a vector to subset the vector or it will think its a matrix
animals[c(2,1)]                  #it doesn't even have to be in order, it will obey the command and put it in the order you call for it to

animals[c(2,2,2)]   #you can ask for the same item multiple times too


#you can also use bouions to do conditional subsetting
animals[c(TRUE, FALSE, TRUE, FALSE)]   #by simply feeding in TRUEs and FALSEs
#every time R sees a False it will not return the item, but every time it sees a True it will return the item

animals[c(TRUE, FALSE, TRUE, FALSE, TRUE)]#couple of features to build off of this; it has to be the same length and item we are trying to index...if we try to add another true here R will throw and error
#it will say NA bc its trying to return a 5th item that doesn't exist

#what if we return fewer
animals[c(TRUE, FALSE)]
#it will only show the first two but this can be dangerous....always know how long your vector is
animals[c(T,F,T,F)] #shorthand way to use bouions

#for data filtering, you may want to filter the actual values, say return numbers above a certain value
weight <- c(101,90,88,112,105)
str(weight)
#say we want to only return weights that are less than 100
weight[weight<100]
weight<100 #if you do not use the brackets for the indexing you will return bouion values that tells you which numbers in the set are less than 100
# you can also add equal signs
weight[weight<=100]
#we can also combine filters, lets say you want to return a case where weight is less than 99 or greater than 110 (bouion vector on its own; in the first two; but you can combine them with the vertical line for the OR sign for conditional operations)
weight < 99
weight > 110
weight < 99 | weight > 110  #if you run it you will get two True values where either less than 99 or greater than 110

#now we can index (brackets) with that combined operation and it will return two numbers 88 and 112
weight[weight < 99 | weight > 110]

#we can do this with strings as well with exact matching
animals
animals=="mouse"
animals[animals=="mouse"]  #what the double equals is saying is are these values the same
animals[animals=="mouse"|animals=="rat"]
#the single equal sign is a way of assigning an object
test='test object'
test=='test object' #it will return a bouion of True bc we assigned it that way
#but if we say something else it will return False because it has not been assigned
test=='something else'



#---------------------

#Changin Visual Defaults

#naviagate to RStudio (top left), then preferences, appearance, then play around with different sizes, and choose an editor theme (dark theme with clear differences; Mervivore is a good one), then apply













