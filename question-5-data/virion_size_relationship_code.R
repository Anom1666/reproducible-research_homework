#Load the packages
library(here)
library(dplyr)
library(ggplot2)

#Load the data
data = read.csv(here("question-5-data", "Cui_etal2014.csv"))

#Perform the log-transformation on both virion volume and genome length
data <- data %>%
  mutate(log_volume = log(Virion.volume..nm.nm.nm.),
         log_genome_length = log(Genome.length..kb.))

linear_model = lm(log_volume ~ log_genome_length, data = data)
summary(linear_model)

#Create the plot
ggplot(data, aes(x = log_genome_length, y = log_volume)) +
  geom_point(color = "black", size = 3) +
  geom_smooth(method = "lm", se = TRUE, color = "blue") +
  labs(x = "log [Genome length (kb)]", y = "log [Virion volume (nm^3)]") +
  theme_minimal() 