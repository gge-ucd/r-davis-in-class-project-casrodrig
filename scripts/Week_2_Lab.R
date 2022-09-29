1+1    #command return to run or highlight and hit run
log(2)
x <- 1    #object oriented language 
          # <- assigns a variable to an object 
log()     # a function (i.e. log()); you can create your own functions; don't use an arrow inside of a function because it could mean something else
          # Alt - <- (for macs it is option -) is a shortcut to create and <- 

a <- 1
b <- 2
c <- a + b
b <- 4
a <- b
c <- a
c         # this would spit out 4 as the answer because a has been assigned b and b has been assigned 4

?c         # ? pulls up an answer for whatever you have a question about (just be sure to put what you are asking after the ?)
  
my.name  <- "Cass"   # assigning words to objects

my_name <- "Cass"

myName <- "Cass"

log(x=3, base = exp(1))  #arguments to a function; it is called setting your arguments
log(3)
log(3, base = 10)

log()
?log
1+1

# an object is a naming of something and a function produces and output of the math or statistics (it solves a problem)

rm() # rm removes objects

ls() #these are all objects in the global environment
rm(a)
ls()


rm(b, c, my_name, my.name, myName)  #you can remove more than one object at a time
ls()
rm(list = ls())       # list a character vector naming objects to be removed; this will remove everything on the list
ls()

?rm  #help with remove objects command

#-----------------------------------------------------------------

getwd()  #determine what your working directory is

## ACTIVITY ---
#1. Use the ABSOLUTE (FULL) filepath to list the files in your in class Rproject data folder
# THIS VERSION OF FILEPATHS IS UNNECCESSARY!
list.files(path ="/Users/cassandrarodriguez/Desktop/R_DAVIS_2022")
#INSTEAD USE THIS VERSION
list.files(path = "data")
#2. Write the RELATIVE filepath (relative to your working diretory)to list the files in your in class Rproject data folder
list.files(ppath = "r-davis-in-class-project-casrodrig/data/")

#--------------------------------------

#add scripts folder
?dir.create
#the path needs to be character ("") bc it is an invalid argument for an object
dir.create(path = "scripts")






