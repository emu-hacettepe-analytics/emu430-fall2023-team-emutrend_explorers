library(thestats)
library(tidyverse)


data <- list_score(region_names = "all", city_names = "Ankara",
                                     university_names = "all", department_names= "Industrial Engineering",
                                     lang = "en", var_ids=c("X141", "X142", "X143", "X144", "X145", "X146","X147", "X148", "X149", 
                                                            "X151", "X152", "X153", "X154", "X155", "X156", "X157", "X158", "X159"))

data1 <- subset(data, department!= "Woodworking Industrial Engineering")

data1 <- na.omit(data1)
colnames(data1) <- c("ID", "Year","Type","Program Code","University","Faculty","Department","number of choices in 1st place","number of choices in 2nd place","number of choices in 3rd place",
                       "number of choices in 4th place","number of choices in 5th place","number of choices in 6th place","number of choices in 7th place",
                       "number of choices in 8th place","number of choices in 9th place",
                       "number of students placed in 1st choice","number of students placed in 2nd choice","number of students placed in 3rd choice","number of students placed in 4th choice",
                       "number of students placed in 5th choice","number of students placed in 6th choice","number of students placed in 7th choice","number of students placed in 8th choice",
                       "number of students placed in 9th choice")
