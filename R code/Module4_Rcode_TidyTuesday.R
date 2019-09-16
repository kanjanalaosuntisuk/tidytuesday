##### Description: Codes for data visualization of Amusement Park injuries (#TidyTuesday project)
##### Author: Kanjana Laosuntisuk
##### Date created: Sep 14, 2019
##### Last modified: Sep 16, 2019

library(tidyverse)

#get the data
tx_injuries <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-10/tx_injuries.csv")

#Filter only "TX" in column state in tx_injuries
tx_injuries_tx <- subset(tx_injuries, st == "TX")

#Filter only "F" and "M" in column gender in tx_injuries_tx
tx_injuries_tx_gender <- subset(tx_injuries_tx, gender == "F" | gender == "M")

#Remove n/a in column age in tx_injuries_tx_gender
tx_injuries_tx_gender_age <- subset(tx_injuries_tx_gender, age != "n/a")

#Change type of column age in tx_injuries_tx_gender_age from character to numeric
tx_injuries_tx_gender_age$age <- as.numeric(tx_injuries_tx_gender_age$age)
str(tx_injuries_tx_gender_age)

#Change city names in column city to ALL CAPITAL LETTERS
tx_injuries_tx_gender_age$city <- toupper(tx_injuries_tx_gender_age$city)

#Make a histogram
Rplot_tx_injuries <- ggplot(data = tx_injuries_tx_gender_age, aes(age, fill = gender)) + 
  geom_histogram(position = "dodge") +
  labs(x = "Age", y = "Number of Individuals", title = "Injuries in Texas Amusement Park", subtitle = "Age and Gender of Injured Individuals in Different Cities", caption = "Data source: data.world and Safer Parks database") +
  scale_fill_discrete(name = "Gender", labels = c("Female", "Male")) +
  theme_grey() +
  facet_wrap(~city, nrow = 10) + 
  scale_y_continuous(breaks = c(2, 4, 6, 8))

#Plot a histogram
plot(Rplot_tx_injuries)

#Save a plot
ggsave("Rplot_tx_injuries.pdf", width = 8.5, height = 11, units = "in")
                     