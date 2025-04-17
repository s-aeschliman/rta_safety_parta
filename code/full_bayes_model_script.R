library(tidyverse)
library(lavaan)
library(blavaan)
#library(bayestestR)
#library(lavaanPlot)
#library(semPlot)
#library(ggplot2)
#library(bayesplot)
#library(viridis)
#library(viridisLite)

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

    satisfaction ~ enforcement_sensitivity + upkeep_sensitivity + mode_CTA_RAIL + mode_CTA_BUS + mode_METRA + age + num_vehicles + income + gender_Female + WITNESSED_CRIME + WITNESSED_NUIS + WOM_SOC_CRIME + WOM_SOC_NUIS + TRAD_CRIME + TRAD_NUIS

'

# SET MCMC PARAMS
num_burnin <- 1000
num_samples <- 2000
num_chains <- 4


# weakly-informative priors on the factor loadings and regression parameters. 
# the default priors for these params are far too diffuse
my_priors <- dpriors(
  lambda = "normal(0, 0.5)", # factor loadings
  beta = "normal(0, 0.5)", # satisfaction regression coefficients
  tau = "normal(0, 0.2)" # ordered thresholds made very narrow to fit the model!
)

prior_pred = FALSE # FALSE for posterior samples, TRUE for prior predictive samples

library(future)
future::plan("multicore") # for parallel processing of post-estimation metrics (LVs, etc)
options(future.globals.maxSize = 1310720000) # 1310720000 = 1.25 GB, 891289600 = 850 MB
# fit the full SEM
b_satisfaction_outcome_results_ordered <- bsem(
  model = satisfaction_outcome_model,
  data = data,
  ordered = c("satisfaction"),
  dp = my_priors, 
  inits = "prior",
  n.chains = num_chains,
  burnin = num_burnin,
  sample = num_samples,
  #save.lvs = TRUE,
  prisamp = prior_pred,
  bcontrol = list(cores = num_chains), # parallel estimation
  mcmcfile = F # save the stan code 
)

bres <- summary(b_satisfaction_outcome_results_ordered, fit.measures = TRUE)

#prpc_plot <- plot(b_satisfaction_outcome_results_ordered, plot.type = "dens")
#ggsave("../figures/prior_predictive_checks.png", dpi=300, width = 8, height = 8)

#lv_cov_prior <- plot(b_satisfaction_outcome_results_ordered, plot.type = "dens", pars = 5)
#ggsave("../figures/lv_cov_prior.png", dpi=300, width = 8, height = 8)

# null model (for incremental fit indices)

# model.null = '

#    MORE_SAFE_POLICE ~~ MORE_SAFE_POLICE
#    MORE_SAFE_PSEC ~~ MORE_SAFE_PSEC
#    MORE_SAFE_K9 ~~ MORE_SAFE_K9
#    MORE_SAFE_LIGHT ~~ MORE_SAFE_LIGHT
#    MORE_SAFE_CLEAN ~~ MORE_SAFE_CLEAN
#    MORE_SAFE_FREQ_REL ~~ MORE_SAFE_FREQ_REL
    
#'

# null.fit <- bcfa(model.null, burnin = num_burnin, sample = num_samples, data = data)

# fit_stats <- blavFitIndices(measurement_model_results, baseline.model = null.fit)

# fit the frequentist version

#freq_model <- sem(
#  satisfaction_outcome_model, 
#  data = data,
#  ordered = c("MORE_SAFE_POLICE", "MORE_SAFE_K9", "MORE_SAFE_PSEC", "MORE_SAFE_CLEAN", "MORE_SAFE_LIGHT", "MORE_SAFE_FREQ_REL")
#)

#fitmeasures(freq_model)

# inspect model outputs and diagnostics


effective_sample_sizes <- blavInspect(b_satisfaction_outcome_results_ordered, what = "neff")
#posterior_lv_means <- blavInspect(b_satisfaction_outcome_results_ordered, what = "lvmeans")
#posterior_lv_samples <- blavPredict(b_satisfaction_outcome_results_ordered, type = "lv") # sample posterior predictive dist

#lv_mean_df <- data.frame(posterior_lv_means)

#lv_mean_df$id <- 1:dsize

#data_with_fit_lvs <- cbind(data, lv_mean_df)

#print("SAMPLING POSTERIOR PREDICTIVE...")

# posterior predictive samples
#yrep <- blavPredict(b_satisfaction_outcome_results_ordered, type="ypred")[num_burnin+1:num_burnin+501]

#yrep <- do.call("rbind", yrep)

save(
  b_satisfaction_outcome_results_ordered, 
  effective_sample_sizes, 
  #yrep,
  num_chains,
  num_burnin,
  num_samples,
  #data_with_fit_lvs,
  #posterior_lv_means, 
  #posterior_lv_samples,
  # save file with current date in the filename
  file = paste0(
    "saved_models/safety_bsem_ordered_", 
    format(Sys.time(), "%Y-%m-%d_%H-%M"), 
    ".RData")
)
