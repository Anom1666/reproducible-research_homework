# Reproducible research: version control and R

\# INSERT ANSWERS HERE #

## Questions 1-3
[Please follow this link](https://github.com/adamg421/MT_Wk3_logistic_growth)

## Question 4

The same code run twice  produces two different 2D random walks each with 500 steps of random direction (any angle between 0 and 360 degrees) and set distance of 0.25, with the shade of blue becoming lighter over time. Both walks start at the same coordinate (0,0), however from there the paths deviate and bear no correlation. This is because both random walks appear irregular and non-deterministic due to the random angle selection. Over time, the paths tend to randomly move away from the origin point, with a random spatial distribution. The paths also self-intersect many times.

![Random Walk Plot](https://github.com/adamg421/reproducible-research_homework/blob/main/question-4-code/plots/Rplot.png)

Computers are incapable of producing random numbers, thus a random seed is provided as a starting point for a pseudorandom number generator (PRNG). The PRNG algorithm will produce a series of numbers that appear random, but are deterministic and will always be the same for a given random seed. This is useful for experimental simulations that require reproducibility. A random seed is often generated from the state of the computer, such as the system clock.

The following shows the edit made to the [random_walk.R](https://github.com/adamg421/reproducible-research_homework/blob/main/question-4-code/random_walk.R) code in order ot make it reproducible. This is done by ensuring the seed is set to the same number (in this case 1) each time the function runs.
![Screenshot 2024-12-12 at 00 53 29](https://github.com/user-attachments/assets/cb2843ec-7adc-4fa0-abae-0443fce57381)

Below you can see that the output each time is the same

![6b6f42f7-7e08-4dc9-8a07-33dcc1c964ac](https://github.com/user-attachments/assets/997a529d-33d5-4699-b339-ad85562788c6)


## Question 5

- The table has 13 columns and 33 rows.
- To fit a linear model for the allometric equation $V = \alpha L^\beta$ we can apply a log transfomration on both V (Virion volume) and L (Genome length). This produces the equation $log(V) = \beta log(L) + log(\alpha)$ that resembles a linear equation y = mx + c.

  In r, this transformation can be applied using the dplyr package in the following way:
  ```
  library(dplyr)
  data <- data %>%
  mutate(log_volume = log(Virion.volume..nm.nm.nm.),
         log_genome_length = log(Genome.length..kb.))
  ```
- The summary of a linear model applied to the log transformed data:
  ```
  linear_model = lm(log_volume ~ log_genome_length, data = data)
   summary(linear_model)
  ```

   <img width="461" alt="Screenshot 2024-12-12 at 01 40 26" src="https://github.com/user-attachments/assets/0c7e7d62-1a62-496e-b90b-e43762239f72" />
   
  - The exponent ($\beta$) is the estimate for the coefficient of the log of genome length = 1.52 (2dp).
    - The p-value was $2.28 \times 10^{-10}$ which is highly significant
  - The scaling factor ($\alpha$) is the exponent of the estimate of the intercept = exp(7.0748) = 1181.81 (2dp).
    - The p-value was $6.44 \times 10^{-10}$ which is highly significant

   As shown by **Table 2** of the paper below, I obtained identical values
  
  ![Screenshot 2024-12-12 at 01 47 18](https://github.com/user-attachments/assets/5f27213a-cc3a-447f-990e-630f7f6e7b8b)

- The following code produces the figure below of log genome length (kb) against log virion volume ($nm^3$). The code can also be found in the repository ([virion_size_relationship_code.R](https://github.com/adamg421/reproducible-research_homework/blob/main/question-5-data/virion_size_relationship_code.R)) 
  ```
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
  ```
  The output figure:
  ![00078169-d5be-440a-99ce-5dde2fbfddf6](https://github.com/user-attachments/assets/0de3f19b-83a4-46c4-b677-c8e2cb7f1a89)

  - To find the estimated volume of a 300kb virus we can input our estimates into the equation:
    - $V = \alpha L^\beta \therefore V = 1181.807 \times 300^{1.5152}$ 
    - $\therefore V = 6697006 nm^3$

## Instructions

The homework for this Computer skills practical is divided into 5 questions for a total of 100 points. First, fork this repo and make sure your fork is made **Public** for marking. Answers should be added to the # INSERT ANSWERS HERE # section above in the **README.md** file of your forked repository.

Questions 1, 2 and 3 should be answered in the **README.md** file of the `logistic_growth` repo that you forked during the practical. To answer those questions here, simply include a link to your logistic_growth repo.

**Submission**: Please submit a single **PDF** file with your candidate number (and no other identifying information), and a link to your fork of the `reproducible-research_homework` repo with the completed answers (also make sure that your username has been anonymised). All answers should be on the `main` branch.

## Assignment questions 

1) (**10 points**) Annotate the **README.md** file in your `logistic_growth` repo with more detailed information about the analysis. Add a section on the results and include the estimates for $N_0$, $r$ and $K$ (mention which *.csv file you used).
   
2) (**10 points**) Use your estimates of $N_0$ and $r$ to calculate the population size at $t$ = 4980 min, assuming that the population grows exponentially. How does it compare to the population size predicted under logistic growth? 

3) (**20 points**) Add an R script to your repository that makes a graph comparing the exponential and logistic growth curves (using the same parameter estimates you found). Upload this graph to your repo and include it in the **README.md** file so it can be viewed in the repo homepage.
   
4) (**30 points**) Sometimes we are interested in modelling a process that involves randomness. A good example is Brownian motion. We will explore how to simulate a random process in a way that it is reproducible:

   a) A script for simulating a random_walk is provided in the `question-4-code` folder of this repo. Execute the code to produce the paths of two random walks. What do you observe? (10 points) \
   b) Investigate the term **random seeds**. What is a random seed and how does it work? (5 points) \
   c) Edit the script to make a reproducible simulation of Brownian motion. Commit the file and push it to your forked `reproducible-research_homework` repo. (10 points) \
   d) Go to your commit history and click on the latest commit. Show the edit you made to the code in the comparison view (add this image to the **README.md** of the fork). (5 points) 

5) (**30 points**) In 2014, Cui, Schlub and Holmes published an article in the *Journal of Virology* (doi: https://doi.org/10.1128/jvi.00362-14) showing that the size of viral particles, more specifically their volume, could be predicted from their genome size (length). They found that this relationship can be modelled using an allometric equation of the form **$`V = \alpha L^{\beta}`$**, where $`V`$ is the virion volume in nm<sup>3</sup> and $`L`$ is the genome length in nucleotides.

   a) Import the data for double-stranded DNA (dsDNA) viruses taken from the Supplementary Materials of the original paper into Posit Cloud (the csv file is in the `question-5-data` folder). How many rows and columns does the table have? (3 points)\
   b) What transformation can you use to fit a linear model to the data? Apply the transformation. (3 points) \
   c) Find the exponent ($\beta$) and scaling factor ($\alpha$) of the allometric law for dsDNA viruses and write the p-values from the model you obtained, are they statistically significant? Compare the values you found to those shown in **Table 2** of the paper, did you find the same values? (10 points) \
   d) Write the code to reproduce the figure shown below. (10 points) 

  <p align="center">
     <img src="https://github.com/josegabrielnb/reproducible-research_homework/blob/main/question-5-data/allometric_scaling.png" width="600" height="500">
  </p>

  e) What is the estimated volume of a 300 kb dsDNA virus? (4 points) 
