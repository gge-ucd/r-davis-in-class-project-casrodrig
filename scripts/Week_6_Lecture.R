id <- ngRok::livestream_start(port = 8080,
                              hostname = "www.rdaviscode.com",
                              password = 'nifflers',
                              user = 'rdavis', scheme = 'http')
# Homework review: -----
## 1. Create a new data frame called surveys_wide with a column for genus and a column named after every plot type, with each of these columns containing the mean hindfoot length of animals in that plot type and genus. The dataframe should be sorted by values in the Control plot type column.
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
summary_table <- surveys %>%
  group_by(genus, plot_type) %>%
  summarize(mean_hfl = mean(hindfoot_length, na.rm = T))
summary_table
surveys_wider <- summary_table %>%
  pivot_wider(names_from = plot_type, values_from = mean_hfl) %>%
  arrange(-Control)  # instead of using desc (to put in descending order you can just use the - )
surveys_wider

# when a package override occurs use :: to call on a specific package you want to use in your code (i.e., dplyr::summarize)

## 2. Use both ifelse() and case_when() to calculate a new weight category variable called weight_cat. For this variable, define the rodent weight into three categories: “small” is less than or equal to the 1st quartile, “medium” is between the 1st and 3rd quartile, and “large” is any weight greater than or equal to the 3rd quartile. What happens to NAs?
summary(surveys$weight)

surveys_cw <- surveys %>%
  mutate(weight_cat = case_when(
    weight <= 20 ~ "small",
    weight > 20 & weight < 48 ~ "medium",
    T ~ "large"
  ))

surveys_cw %>%
  group_by(weight_cat) %>%
  summarize(min = min(weight, na.rm = T),
            max = min(weight, na.rm = T))  # this will show you if your categories were input correctly and if NAs affecting it
surveys_cw %>%
  filter(is.na(weight)) %>%
  select(weight, weight_cat) %>%
  head() # check to see what happened in the NAs; we do want to see all NAs in the head to see that you managed your NAs properly

# ifelse: binary only, so you need to nest the function, requires a final "no" argument; does not assign NAs into that final category


# Intro to ggplot -----
# bit.ly/3TEZ2Jd

## 3 parts of a ggplot:
## (1) ggplot(data = <DATA>, (2) mapping = aes(<MAPPINGS>) +
##    (3) <GEOM_FUNCTION>()


## The basic idea:
ggplot(surveys_cw, aes(x = weight_cat, y = hindfoot_length)) +
  geom_jitter() +
  geom_boxplot()

## Layer order matters

ggplot(surveys_cw, aes(x = weight_cat, y = hindfoot_length)) +
  geom_jitter() +
  geom_boxplot()


## Aesthetics are mobile!
ggplot(surveys_cw, aes(x = weight_cat,
                       y = hindfoot_length,
                       color = plot_type)) +
  geom_jitter() +
  geom_boxplot()

ggplot(surveys_cw, aes(x = weight_cat,
                       y = hindfoot_length)) +
  geom_jitter() +
  geom_boxplot(aes(color = plot_type))

## Features that relate directly to the data go in the aes() function, all else are their own arguments within the geoms

ggplot(surveys_cw, aes(x = weight_cat,
                       y = hindfoot_length)) +
  geom_jitter() +
  geom_boxplot(color = "red")

# third challenge:
surveys %>%
  filter(species_id == "NL" | species_id == "PF") %>%  # you have to have filter function to seperately isolate each value you want for your GEOM
  ggplot(aes(x = species_id,
             y = hindfoot_length)) +
  geom_jitter(aes(color = plot_type)) +
  geom_boxplot()


surveys %>%
  filter(species_id %in% c("NL","PF")) %>%
  ggplot(aes(x = species_id,
             y = hindfoot_length)) +
  geom_jitter(aes(color = as.factor(plot_id))) +
  geom_boxplot()



# time series
# faceting
# themes

library(ngRok)
ngRok::livestream_start('www.rdaviscode.com','nifflers','rdavis',8080)
library(tidyverse)
id <- "F53066D9"
#ngRok::livestream_stop(id)
library(tidyverse)
surveys_complete <- read_csv("data/portal_data_joined.csv") %>%
  filter(complete.cases(.))


yearly_counts <- surveys_complete %>%
  count(year, species_id)

head(yearly_counts)

g = ggplot(data = yearly_counts)
g + geom_point(aes(x = year,y = n)) +
geom_path(aes(x = year,y = n,group = species_id))

# can also group by color
g = ggplot(data = yearly_counts)
g + geom_point(aes(x = year,y = n)) +
  geom_path(aes(x = year,y = n,colour = species_id)) # can also use geom_line to do this instead of path

geom_path(mapping = aes(x = year,y = n))

#grouped by species
ggplot(data = yearly_counts) +
  geom_path(mapping = aes(x = year,y = n,group = species_id))
# add color
ggplot(data = yearly_counts,mapping = aes(x = year,colour = species_id,
                                          y = n,group = species_id)) +
  geom_path() + geom_point()

# facetting
ggplot(data = yearly_counts) +
  geom_path(mapping = aes(x = year,y = n,group = species_id)) +
  facet_wrap(~species_id,scales = "free_y")

ggplot(data = yearly_counts) +
  geom_path(mapping = aes(x = year,y = n, color = species_id)) +
  facet_wrap(~species_id,ncol = 3)

yearly_counts2 <- surveys_complete %>%
  count(year, species_id,sex)
head(yearly_counts2)
head(yearly_counts)

ggplot(data = yearly_counts2) +
  geom_path(aes(x = year,y = n,colour = species_id)) +
  facet_grid(sex~species_id)

ggplot(data = yearly_counts2) +
  geom_path(aes(x = year,y = n,colour = species_id)) +
  facet_wrap(sex~species_id,nrow = 2)

ggplot(data = yearly_counts2) +
  geom_path(aes(x = year,y = n,colour = species_id)) +
  facet_wrap(sex~species_id,ncol = 2)

DM
library(ggthemes)
ggplot(data = yearly_counts,mapping = aes(x = year,colour = species_id,                                          y = n,group = species_id)) +
  geom_path() + geom_point() + theme_stata()

library(ggthemes)
ggplot(data = yearly_counts,mapping = aes(x = year,colour = species_id,                                          y = n,group = species_id)) +
  geom_path() + geom_point() + theme_stata()

yearly_counts2 %>%
  filter(species_id %in% c('BA','DM'))
library(ggthemes)
ggplot() +
  geom_path(aes(x = year,y = n,colour = species_id)) +
  facet_wrap(sex~species_id,nrow = 2) + theme_state()

DM
library(ggthemes)
ggplot(data = yearly_counts,mapping = aes(x = year,colour = species_id,                                          y = n,group = species_id)) +
  geom_path() + geom_point() + theme_stata()
