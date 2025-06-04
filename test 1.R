library(tidyverse)
library(janitor)
library(stringr)
library(ggplot2)
library(dplyr)


## 1.Read csv and clean column names and print column names

read_csv("10_Property_stolen_and_recovered.csv")->prop
prop
prop<-clean_names(prop)
colnames(prop)


## 2 Rename area_name to state_ut

prop%>%
rename(state_ut = area_name)->prop1
prop1

# 3 how many state_ut are there
prop1%>%
count("state_ut")

## 4 how many crime groups are there and what are those

prop1%>%
  count("group_name")
prop1%>%
  select(c("group_name"))

## 5 in group_name what is "total property" and what should we do

prop1 %>% 
  filter(group_name != "Total Property")->prop2
## 


## 6 what is the total no of property stolen cases and total value - ALL india
prop2%>%
  count("cases_property_stolen")


prop2 %>%
  summarise(
    total_cases = sum(cases_property_stolen),
    total_value = sum(value_of_property_stolen)
  )->yearwise

## 7 what is the total no of property stolen cases and total value - 
##all india - year wise.() (with table and plot)


ggplot(prop2, aes(x = year, y = cases_property_stolen)) +
  geom_line(color = "red", size = 1) +
  geom_point(color = "darkblue") +
  facet_wrap(~year)+
  labs(title = "yearwise property stolen cases in India",
       x = "Year",
       y = "Number of Cases")+
  theme_minimal()


## 8 states with no of cases,plot the same
  


