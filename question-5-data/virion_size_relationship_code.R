#Load the necessary packages
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


#Load the necessary packages
library(here)
library(dplyr)
library(ggplot2)

#Load the data
data = read.csv(here("question-5-data", "Cui_etal2014.csv"))

#Perform the log-transformation on both virion volume and genome length
data <- data %>%
  mutate(log_volume = log(Virion.volume..nm.nm.nm.),
         log_genome_length = log(Genome.length..kb.))
