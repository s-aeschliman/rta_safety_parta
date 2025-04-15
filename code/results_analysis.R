library(tidyverse)
library(blavaan)
library(bayestestR)

setwd("/Users/aesch/Documents/Grad School/projects_grad/rta/safety study/code")

# load the survey data
data <- read_csv("../data/data_for_sem.csv")

# load in the outputs from the SEM
load("safety_bsem.RData")

summary(b_satisfaction_outcome_results)

# latent variables
lv_means_long <- pivot_longer(data.frame(posterior_lv_means), cols = 1:2, names_to = "LV", values_to = "mean")

lv_samples_enf <- data.frame(posterior_lv_samples) %>% 
    select(matches("enforcement_sensitivity")) %>%
    pivot_longer(cols = everything(), names_to = "Sample number", values_to = "sampled_value") %>%
    mutate(id = rep(1:12000, 2093))

lv_samples_qi <- data.frame(posterior_lv_samples) %>% 
    select(matches("upkeep_sensitivity")) %>%
    pivot_longer(cols = everything(), names_to = "Sample number", values_to = "sampled_value") %>%
    mutate(id = rep(1:12000, 2093))

lvs_and_captive <- data_with_fit_lvs %>%
    select(UNID, num_vehicles, income, enforcement_sensitivity, upkeep_sensitivity)


inc_veh_df <- lvs_and_captive %>% 
                    group_by(num_vehicles, income) %>% 
                    summarize(mean_enf = mean(enforcement_sensitivity)) 

d <- ggplot(data = inc_veh_df, aes(x = num_vehicles, y = income, fill = mean_enf)) +
    geom_tile() +
    scale_fill_viridis_c() +
    theme_minimal() +
    labs(title = "Enforcement Sensitivity by Income and Number of Vehicles",
         x = "Number of Vehicles",
         y = "Income",
         fill = "Enforcement Sensitivity") +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("../figures/enf_sens_inc_veh.png", dpi=300, width = 8, height = 8)

# table of effective sample sizes

print(effective_sample_sizes)