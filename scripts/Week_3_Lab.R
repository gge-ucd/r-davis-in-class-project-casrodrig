# always convert spreadsheets to .csv to be read in R

read.csv("data/portal_data_joined.csv")
surveys <- read.csv("data/portal_data_joined.csv")
View(surveys)


class(surveys)
# class surveys is a data.frame

str(surveys)
# 34785 rows and 13 columns

surveys <- read.csv("data/portal_data_joined.csv", stringsAsFactors = F)
View(surveys)
unique(surveys$species)    #list all species
length(unique(surveys$species))
table(surveys$species)


#using a data.frame instead of a vector....data.frame is essentially a bunch of vectors together; when we index with 2D
surveys[,]
# [row, column]

surveys[5,7]
surveys[1:10, 1:10]
#index first 10 row and 10 columns

#Index by name rather than number, Why? More flexible to modification, more often than not $ is what people use not to call for a column, insteasd of using square brackets; so you would do surveys$species_id (you put the header name after the dollar sign)
surveys[,"species_id"]
surveys$species_id

surveys$record_id[5] #this function will call the 5th column in the record_id column


surveys_200 <- surveys[200,]
surveys_200
str(surveys)
surveys_last <- surveys[34786,]
surveys_last

#default dimension is column
head(surveys[1])
surveys["record_id"]


nrow(surveys)
surveyslast <- surveys[34786, 1:13]
surveys_last


#can we make this stronger?
surveys_last <- surveys[nrow(surveys), 1:13]
surveys_last


