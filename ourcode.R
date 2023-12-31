library(thestats)
library(ggplot2)
library(tidyverse)
library(gridExtra)


data <- list_score(region_names = "all", city_names = "Ankara",
                   university_names = "all", department_names= "Industrial Engineering",
                   lang = "en", var_ids=c("X141", "X142", "X143", "X144", "X145", "X146","X147", "X148", "X149", 
                                        "X151", "X152", "X153", "X154", "X155", "X156", "X157", "X158", "X159"))
selected_university  <- c("Industrial Engineering (English) (Scholarship)","Industrial Engineering (English)","Industrial Engineering(English)",
"Industrial Engineering (English) (Scholarship)","	
Industrial Engineering(English)(Scholarship)","Industrial Engineering (Scholarship)","	
Industrial Engineering (English) (Scholarship)","Industrial Engineering(English)(Scholarship)","Industrial Engineering (English) (Scholarship)",
"Industrial Engineering(English)(Scholarship)","Industrial Engineering (English)","Industrial Engineering(English)","Industrial Engineering (Scholarship)",
"Industrial Engineering (Scholarship)","Industrial Engineering (English) (Scholarship)","Industrial Engineering (English) (Scholarship)")




our_data <-na.omit(data)

colnames(our_data) <- c("ID", "Year","Type","Program Code","University","Faculty","Department","choice_1st","choice_2nd",
                        "choice_3rd","choice_4th","choice_5th","choice_6th",
                        "choice_7th","choice_8th","choice_9th",
                        "placed_1st", "placed_2nd", "placed_3rd",
                        "placed_4th","placed_5th","placed_6th",
                        "placed_7th","placed_8th","placed_9th")

our_data <- our_data %>% filter (Department %in% selected_university)

save(our_data, file = "ourdata.rda")


# The statistics of universities located in Ankara in terms of being the first choice for  students
plot_1 <- ggplot(our_data, aes(x = Year, y = choice_1st)) +
  geom_col(fill="pink")+
  labs(x = "Year",y = "The Number of choices in 1st place")+
  ggtitle("The statistics of universities located in Ankara in terms of being the first choice for students") +
  theme_minimal() +
  theme(axis.title = element_text(color = "purple"))+
  facet_wrap(.~ University)




# The statistics of universities located in Ankara in terms of being the placed in 1st choice for students
plot_2 <- ggplot(our_data, aes(x = Year, y = placed_1st)) + 
  geom_col(fill="lightblue") +
 labs(x = "Year",y = "The Number of students placed in first choice")+
  ggtitle("The statistics of universities located in Ankara in terms of being the placed in first choice for students") +
  theme_minimal() +
  theme(axis.title = element_text(color = "blue"))+
  facet_wrap(.~ University)
  
  


# Placement rate for students' first choices


departments <- c("Industrial Engineering(English)","Industrial Engineering (English) (Scholarship)")
placment_rate_data <- our_data %>% filter(Department %in% departments) %>% mutate(placement_rate = placed_1st/choice_1st) %>% select(Year, University, placement_rate)

plot_3 <- ggplot(na.omit(placment_rate_data), aes(x = as.factor(Year), y = placement_rate)) +
  geom_col(fill="lightgreen") +
  labs(x = "Year",y = "Placement Rate")+
  ggtitle("Placement rate for students' first choices over year") +
  theme_minimal() +
  theme(axis.title = element_text(color = "green"))+
  facet_wrap(.~ University)

# Look at only Hacettepe University data

# Hacettepe University Industrial Engineering data in 2018

hacettepe_data1 <- our_data %>% filter(University == "Hacettepe University",Year == 2018)


df_long1 <- pivot_longer(hacettepe_data1, cols = starts_with("choice"),
                        names_to = "Choice", values_to = "Value")

plot_4 <- ggplot(df_long1, aes(x= Choice, y = Value))+
  geom_col(fill="pink")+
  labs(x = "xnd chocie",y = "The Number of choices ")+
  ggtitle("2018") +
  theme_minimal() +
  theme(axis.title = element_text(color = "purple"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))



# Hacettepe University Industrial Engineering data in 2019
hacettepe_data2 <- our_data %>% filter(University == "Hacettepe University",Year == 2019)


df_long2 <- pivot_longer(hacettepe_data2, cols = starts_with("choice"),
                        names_to = "Choice", values_to = "Value")

plot_5 <- ggplot(df_long2, aes(x= Choice, y = Value))+
   geom_col(fill="lightblue")+
  labs(x = "xnd chocie",y = "The Number of choices")+
  ggtitle("2019") +
  theme_minimal() +
  theme(axis.title = element_text(color = "blue"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


# Hacettepe University Industrial Engineering data in 2020

hacettepe_data3 <- our_data %>% filter(University == "Hacettepe University",Year == 2020)


df_long3 <- pivot_longer(hacettepe_data3, cols = starts_with("choice"),
                         names_to = "Choice", values_to = "Value")

plot_6 <- ggplot(df_long3, aes(x= Choice, y = Value)) + 
  geom_col(fill="lightgreen")+
  labs(x = "xnd chocie",y = "The Number of choices")+
  ggtitle("2020") +
  theme_minimal() +
  theme(axis.title = element_text(color = "green"))+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


grid.arrange (plot_4, plot_5, plot_6, ncol = 3)


# Average of number of first choices in all years

avg_first_choices <- our_data %>% group_by(Type, University) %>% 
  summarize(avg_1st_choices = mean(choice_1st)) %>%
  arrange(desc(avg_1st_choices))
