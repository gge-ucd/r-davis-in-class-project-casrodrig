# Homework this week will be playing with the surveys data we worked on in class. First things first, open your r-davis-in-class-project and pull. Then create a new script in your scripts folder called week_3_homework.R.

# Load your survey data frame with the read.csv() function. Create a new data frame called surveys_base with only the species_id, the weight, and the plot_type columns. Have this data frame only be the first 60 rows. Convert both species_id and plot_type to factors. Explore these variables and try to explain why a factor is different from a character. Remove all rows where there is an NA in the weight column.

surveys <- read.csv(file = "data/portal_data_joined.csv") 
surveys_base <- surveys[1:60, c("species_id", "weight", "plot_type")]  # this selects rows 1-60 (1:60), and then creates a new dataframe thorugh the cancatnate function with the three columns I want
surveys_base # just to make sure I did it right ;)

surveys_base$species_id <- as.character(surveys_base$species_id) # converting species_id to a factor and then changing it to a character; $ operator is used to extract or subset a specific part of a data object in R, as.character() function in R converts a numeric object to a string data type or a character object

surveys_base$plot_type <- as.character(surveys_base$plot_type) # converting plot_type to a factor and character object; main difference between a factor and character function is that factors have predefined levels. Their value can only be one of those levels or NA. Whereas characters can be anything

# Factors are stored as numbers and a table of levels. If you have categorical data, storing it as a factor may save lots of memory. Comparisons with factors should be quicker too because equality is tested by comparing the numbers, not the character values. The advantage of keeping it as character comes when you want to add new items, since you are now changing the levels. Store them as whatever makes the most sense for what the data represent. If name is not categorical, and it sounds like it isn't, then use character.

surveys_base <- surveys_base[complete.cases(surveys_base), ] # selecting rows that have complete cases, so it will remove the NAs from the rows and then put the comma after so that you are not messing with the columns; You can use the complete.cases() function in R to remove missing values in a vector, matrix, or data frame.
surveys_base


# CHALLENGE: Create a second data frame called challenge_base that only consists of individuals from your surveys_base data frame with weights greater than 150g.

challenge_base <- surveys_base[(surveys_base[, "weight"]>150),]  # we are telling R to select from the weight column weights that are only greater than 150 grams by subsetting, and by not putting anything in the last column after the comma it will return the species_id and plot_type column for all weights greater than 150 g
challenge_base
