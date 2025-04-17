library(tidyverse)
library(lavaan)
library(blavaan)
library(bayestestR)
library(lavaanPlot)
library(semPlot)
library(ggplot2)
library(bayesplot)
library(viridis)
library(viridisLite)

#setwd("/Users/aesch/Documents/Grad School/projects_grad/rta/safety study/code")
# load the previously processed data
data <- read_csv("../data/data_for_sem.csv")

dsize <- nrow(data)

# just the standard measurement model
satisfaction_measurement_model = "
    enforcement_sensitivity =~ MORE_SAFE_POLICE + MORE_SAFE_K9 + MORE_SAFE_PSEC
    upkeep_sensitivity =~ MORE_SAFE_CLEAN + MORE_SAFE_LIGHT + MORE_SAFE_FREQ_REL

"

satisfaction_outcome_model = '

### ------------------------------ MEASUREMENT MODEL --------------------------------

    enforcement_sensitivity =~ MORE_SAFE_K9 + MORE_SAFE_POLICE + MORE_SAFE_PSEC 
    upkeep_sensitivity =~ MORE_SAFE_CLEAN + MORE_SAFE_LIGHT + MORE_SAFE_FREQ_REL 

    enforcement_sensitivity ~~ upkeep_sensitivity

### ------------------------------ STRUCTURAL MODEL --------------------------------

    # ------------------------------- LV regressions ---------------------------

    enforcement_sensitivity ~  WITNESSED_CRIME + WOM_SOC_CRIME + TRAD_CRIME + race_White + race_Black + race_Asian
    upkeep_sensitivity ~ WITNESSED_NUIS + WOM_SOC_NUIS + TRAD_NUIS

    # ------------------------------- outcome regression ---------------------------  

    satisfaction ~ enforcement_sensitivity + upkeep_sensitivity + mode_CTA_RAIL + mode_CTA_BUS + mode_METRA + age + num_vehicles + income + gender_Female + WITNESSED_CRIME +   WITNESSED_NUIS + WOM_SOC_CRIME + WOM_SOC_NUIS + TRAD_CRIME + TRAD_NUIS

'

# SET MCMC PARAMS
num_burnin <- 500
num_samples <- 1000
num_chains <- 4


# weakly-informative priors on the factor loadings and regression parameters. 
# the default priors for these params are far too diffuse
my_priors <- dpriors(
  lambda = "normal(0, 0.3)", # factor loadings
  beta = "normal(0,1)", # satisfaction regression coefficients
  # nu = "normal(6, 3)" # satisfaction regression intercept
  tau = "normal(0, 0.2)" # threshold parameters
)

prior_pred = FALSE # FALSE for posterior samples, TRUE for prior predictive samples

library(future)
future::plan("multicore") # for parallel processing of post-estimation metrics (LVs, etc)

options(future.globals.maxSize = 891289600)
# fit the full SEM
b_satisfaction_outcome_results <- bsem(
  model = satisfaction_outcome_model,
  data = data,
  ordered = c("satisfaction"),
  dp = my_priors, 
  n.chains = num_chains,
  burnin = num_burnin,
  sample = num_samples,
  # save.lvs = TRUE,
  prisamp = prior_pred,
  bcontrol = list(cores = 4), # parallel estimation
  mcmcfile = T # save the stan code 
)

bres <- summary(b_satisfaction_outcome_results, fit.measures = TRUE)

# inspect model outputs and diagnostics

effective_sample_sizes <- blavInspect(b_satisfaction_outcome_results, what = "neff")
#posterior_lv_means <- blavInspect(b_satisfaction_outcome_results, what = "lvmeans")
#posterior_lv_samples <- blavPredict(b_satisfaction_outcome_results, type = "lv") # sample posterior predictive dist

#lv_mean_df <- data.frame(posterior_lv_means)

#lv_mean_df$id <- 1:dsize

#data_with_fit_lvs <- cbind(data, lv_mean_df)

#print("SAMPLING POSTERIOR PREDICTIVE...")

# posterior predictive samples
#yrep <- blavPredict(b_satisfaction_outcome_results, type="ypred")[2001:2500]

#yrep <- do.call("rbind", yrep)

savepath <- "saved_models"
day <- Sys.Date()
time <- format(Sys.time(), "%H-%M")
filepath <- file.path(savepath, day, paste0(time))
dir.create(filepath, showWarnings = FALSE)

filename <- "results.RData"
notes <- c("Full SEM model with ordinal outcome variable.",
  "Posterior predictive samples and LVs were not saved.", 
  "Model was run with 4 chains, 500 burnin, and 1000 samples per chain.", 
  "The model was run on 4 cores in parallel.",  
  "Priors:",
  "lambda = normal(0, 0.3),", # factor loadings
  "beta = normal(0,1),", # satisfaction regression coefficients
  "tau = normal(0, 0.2). inits was not set.",
  "future globals max size was set to 850 MB.")

fileconn <- file("notes.txt")
writeLines(notes, fileconn)
close(fileconn)

save(
  b_satisfaction_outcome_results, effective_sample_sizes,
  num_burnin, num_samples, num_chains, 
  #data_with_fit_lvs, yrep,
  #posterior_lv_means, posterior_lv_samples,
  # save file with date/time stamp
  file = "ordered_results.RData"
)
