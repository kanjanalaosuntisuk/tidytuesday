##### Description: Codes for data visualization of Amusement Park injuries (#TidyTuesday project)
##### Author: Kanjana Laosuntisuk
##### Date created: Sep 14, 2019
##### Last modified: Sep 15, 2019

library(tidyverse)

#get the data
tx_injuries <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-09-10/tx_injuries.csv")

#Use tx_injuries dataset for data visualization

#Filter only "TX" in state column of tx_injuries
tx_injuries_tx <- subset(tx_injuries, st == "TX")

#Filter only "F" and "M" in gender column pf tx_injuries_tx
tx_injuries_tx_gender <- subset(tx_injuries_tx, gender == "F" | gender == "M")

#Remove n/a in age column of tx_unjuries_tx_gender
tx_injuries_tx_gender_age <- subset(tx_injuries_tx_gender, age != "n/a")

#Change type of age column from character to numeric
tx_injuries_tx_gender_age$age <- as.numeric(tx_injuries_tx_gender_age$age)
str(tx_injuries_tx_gender_age)

#Change city names to ALL CAPITAL LETTERS
tx_injuries_tx_gender_age$city <- toupper(tx_injuries_tx_gender_age$city)

#Make a histogram
ggplot(data = tx_injuries_tx_gender_age, aes(age, fill = gender)) +
  geom_histogram(position = "dodge") +
  labs(x = "Age", y = "Number of Individuals", title = "Injuries in Texas Amusement Park", subtitle = "Age and Gender of Injured Individuals in Different Cities", caption = "Data source: data.world and Safer Parks database") +
  scale_fill_discrete(name = "Gender", labels = c("Female", "Male")) +
  theme_grey() +
  facet_wrap(~city, nrow = 10) + 
  scale_y_continuous(breaks = c(2, 4, 6, 8))

                     