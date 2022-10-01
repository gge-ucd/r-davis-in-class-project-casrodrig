set.seed(15) #set.seed function in R is used to create reproducible results when writing code that involves creating variables that take on random values. By using the set. seed() function, you guarantee that the same random values are produced each time you run the code.

hw2 <- runif(50, 4, 50) #runif function generates random deviates of the uniform distribution and is written as runif(n, min = 0, max = 1) . We may easily generate n number of random samples within any interval, defined by the min and the max argument.

hw2 <- replace(hw2, c(4,12,22,27), NA) #Replacing values in a data frame is a very handy option available in R for data analysis. Using replace() in R, you can switch NA, 0, and negative values with appropriate to clear up large datasets for analysis.

hw2

#1. Take your hw2 vector and remove all the NAs then select all the numbers between 14 and 38 inclusive, call this vector prob1.
prob1 <- hw2[ !is.na(hw2) & ( hw2 >= 14 & hw2 <= 38)] 
#combining multiple conditions to a subset; !is.na() removes all NAs from a vector; & combines the operation within the subset
prob1



#2. Multiply each number in the prob1 vector by 3 to create a new vector called times3. Then add 10 to each number in your times3 vector to create a new vector called plus10.

times3 <- prob1*3  # * is used to multiply each number in the dataset when written this way
times3

pulse10 <- times3 + 10 # to add each number in the vector just use the + sign
pulse10

#3. Select every other number in your plus10 vector by selecting the first number, not the second, the third, not the fourth, etc. If you’ve worked through these three problems in order, you should now have a vector that is 12 numbers long that looks exactly like this one:
##  [1] 105.09174  57.04763  92.25447  83.74723 100.07297  87.73902  57.43049
##  [8]  92.76726  93.19901  85.12543  69.44137  67.57845

pulse10[c(TRUE, FALSE)]

#If logical vectors (T/F) are used for indexing in R, their values are recycled if the index vector is shorter than the vector containing the values.
#the vector pulse10 contains 23 values. If the index vector c(TRUE, FALSE) is used, the actual command is: remove[c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, TRUE, FALSE, etc...)]
#Hence, all values with odd index numbers are selected.




