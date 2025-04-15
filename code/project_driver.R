# Author: Spencer Aeschliman
# Code for: Counter-productive interventions? Satisfaction and safety policy
#           trade-offs in post-pandemic transit ridership            

# This is the full project workflow. Executing this script will provide all of the 
# results and visualizations seen in the paper. it starts from the very beginning 
# (reading in the raw survey data) and goes to the very end (tidying up figures). 
# see the individual .R files for the code at each step



setwd("/Users/aesch/Documents/Grad School/projects_grad/rta/safety study/code")

# take raw data and prep for model
source("prep_data.R")

# estimate the model
source("full_bayes_model_script.R")

# visualize model outputs
source("results_viz.R")

