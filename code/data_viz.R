library(tidyverse)

setwd("/Users/aesch/Documents/Grad School/projects_grad/rta/safety study/code")

# load the survey data
raw <- full_sat_data <- read_csv("../raw/wave_8.csv") # %>% select(-c(FREQ8, MODE8, MODE, GENDRN, HHVEHN, INC4WGTN, RACE4WGTN, PURP8, TRNST_LYLTY))
data <- read_csv("../data/data_for_sem.csv")
# fix the satisfaction column (1 and 10 are character strings for some reason)
full_sat_data$CSS_3_OVSAT[full_sat_data$CSS_3_OVSAT == "Very Dissatisfied1"] <- 1
full_sat_data$CSS_3_OVSAT[full_sat_data$CSS_3_OVSAT == "Very Satissfied10"] <- 10
full_sat_data$satisfaction <- as.numeric(full_sat_data$CSS_3_OVSAT)


raw %>% count(GENDRN) %>% mutate(pct = 100*n/sum(n))
raw %>% count(AGEGRN) %>% mutate(pct = 100*n/sum(n))
raw %>% count(HHVEHN) %>% mutate(pct = 100*n/sum(n))
raw %>% count(INC4WGTN) %>% mutate(pct = 100*n/sum(n))
raw %>% count(RACE4WGTN) %>% mutate(pct = 100*n/sum(n))

# make sure data cleaning doesn't change the distribution of the outcome variable

# satisfaction histogram BEFORE CLEANING
sathist <- ggplot(full_sat_data, aes(x = satisfaction)) + 
  geom_histogram(binwidth = 1, fill = "blue") +
  labs(title = "Satisfaction Histogram", x = "Satisfaction", y = "Frequency")

# satisfaction histogram AFTER CLEANING
sathist1 <- ggplot(data, aes(x = satisfaction)) + 
  geom_histogram(binwidth = 1, fill = "blue") +
  labs(title = "Satisfaction Histogram CLEANED", x = "Satisfaction", y = "Frequency")

# compare distributions
mean(full_sat_data$satisfaction)
sd(full_sat_data$satisfaction)

mean(data$satisfaction)
sd(data$satisfaction)

data$owns_vehicle <- ifelse(data$num_vehicles == 0, 0, 1)

satcrime <- ggplot(data, aes(x = satisfaction, color = as.factor(WITNESSED_CRIME), fill = as.factor(WITNESSED_CRIME), group = as.factor(WITNESSED_CRIME))) + 
  geom_histogram(binwidth = 1, alpha = 0.4) +
  scale_fill_manual(values = c("#4a4af6", "#ff4545")) +
  scale_color_manual(values = c("darkblue", "darkred")) +
  scale_x_continuous(breaks = seq(1,10,1)) +
  guides(color = "none") + 
  labs(
       x = "Satisfaction", y = "Count",
       fill = "Has witnessed a crime on transit?",
       color = element_blank()) + 
  theme(panel.background = element_rect(fill = "white"),
        plot.background = element_rect(fill = "white"),
        axis.line.x = element_line(color = "black"),
        axis.line.y = element_line(color = "black"),
        axis.text = element_text(color = "black"),
        text = element_text(color = "black"),
        panel.grid.major.y = element_blank(),
        legend.position = "top") 

sat_dist <- ggplot(data, aes(x = satisfaction)) +
            geom_histogram(binwidth = 1, fill = "gray90", color = "gray45", alpha = 0.4) +
            labs(x = "Satisfaction", y = "Count") +
            scale_x_continuous(breaks = seq(1,10,1)) +
            theme(panel.background = element_rect(fill = "white"),
            plot.background = element_rect(fill = "white"),
            axis.line.x = element_line(color = "black"),
            axis.line.y = element_line(color = "black"),
            axis.text = element_text(color = "black"),
            text = element_text(color = "black"),
            panel.grid.major.y = element_blank()) 

cowplot::plot_grid(sat_dist, satcrime, ncol = 2)

ggsave("../figures/sat_dists.png", dpi=250, width = 8, height = 4)

library(gridExtra)
#grid.arrange(sathist, sathist1, ncol = 2)

# ggplot theme customization
theme_set(theme_classic() + 
          theme(panel.background = element_rect(fill = "white"),
                plot.background = element_rect(fill = "white"),
                axis.line.x = element_line(color = "black"),
                axis.line.y = element_line(color = "black"),
                axis.text = element_text(color = "black"),
                text = element_text(color = "black"),
                panel.grid.major.y = element_line(color = "grey")
                )
        )

ls_pol_dist <- ggplot(data = data,
                      aes(x = MORE_SAFE_POLICE)) + 
                      geom_histogram(
                             aes(y = ..density..),
                             bins=3,
                             color = "red", 
                             fill = "#ff8888", 
                             alpha = 0.8,
                             linewidth = 1.2
                             ) +
              labs(title = "Police presence", x = "") + 
              scale_x_continuous(breaks = c(-1,0,1), labels = c("Less safe", "Neutral", "More safe")) + 
              ylim(0,1)


ls_psec_dist <- ggplot(data = data,
                      aes(x = MORE_SAFE_PSEC)) + 
                      geom_histogram(
                             aes(y = ..density..),
                             bins=3,
                             color = "red", 
                             fill = "#ff8888", 
                             alpha = 0.8,
                             linewidth = 1.2
                             ) +
              labs(title = "Private security presence", x = "") + 
              scale_x_continuous(breaks = c(-1,0,1), labels = c("Less safe", "Neutral", "More safe")) +
              ylim(0,1)

ls_k9_dist <- ggplot(data = data,
                      aes(x = MORE_SAFE_K9)) + 
                      geom_histogram(
                             aes(y = ..density..),
                             bins=3,
                             color = "red", 
                             fill = "#ff8888", 
                             alpha = 0.8,
                             linewidth = 1.2
                             ) +
              labs(title = "K9 dog presence", x = "") + 
              scale_x_continuous(breaks = c(-1,0,1), labels = c("Less safe", "Neutral", "More safe")) +
              ylim(0,1)


ls_clean_dist <- ggplot(data = data,
                      aes(x = MORE_SAFE_CLEAN)) + 
                      geom_histogram(
                             aes(y = ..density..),
                             bins=3,
                             color = "blue", 
                             fill = "#9898ff", 
                             alpha = 0.8,
                             linewidth = 1.2
                             ) +
              labs(title = "Cleaner facilities", x = "") + 
              scale_x_continuous(breaks = c(-1,0,1), labels = c("Less safe", "Neutral", "More safe")) + 
              ylim(0,1)


ls_light_dist <- ggplot(data = data,
                      aes(x = MORE_SAFE_LIGHT)) + 
                      geom_histogram(
                             aes(y = ..density..),
                             bins=3,
                             color = "blue", 
                             fill = "#9898ff", 
                             alpha = 0.8,
                             linewidth = 1.2
                             ) +
              labs(title = "Well-lit facilities", x = "") + 
              scale_x_continuous(breaks = c(-1,0,1), labels = c("Less safe", "Neutral", "More safe")) + 
              ylim(0,1)
              
ls_freq_dist <- ggplot(data = data,
                      aes(x = MORE_SAFE_FREQ_REL)) + 
                      geom_histogram(
                             aes(y = ..density..),
                             bins=3,
                             color = "blue", 
                             fill = "#9898ff", 
                             alpha = 0.8,
                             linewidth = 1.2
                             ) +
              labs(title = "Frequent and reliable service", x = "") + 
              scale_x_continuous(breaks = c(-1,0,1), labels = c("Less safe", "Neutral", "More safe")) + 
              ylim(0,1)

cowplot::plot_grid(ls_pol_dist, ls_psec_dist, ls_k9_dist, ncol = 3) 

ggsave("../figures/enforcement_dists.png", dpi=200, width = 16, height = 4)

cowplot::plot_grid(ls_clean_dist, ls_light_dist, ls_freq_dist, ncol = 3) 

ggsave("../figures/quality_dists.png", dpi=200, width = 16, height = 4)

data %>% count(gender_Female)
data %>% count(age)
data %>% count(income)
data %>% count(num_vehicles)
