library(blavaan)
library(tidyverse)
library(bayesplot)
library(gridExtra)
library(latex2exp)

#setwd("/Users/aesch/Documents/Grad School/projects_grad/rta/safety study/code")

my_theme  <- theme(
  axis.text = element_text(size = 15),
  axis.title = element_text(size = 15),
  title = element_text(size = 16),
  legend.title = element_blank()
)

# load the survey data
data <- read_csv("../data/data_for_sem.csv")

# load in the outputs from the SEM
load("saved_models/2025-04-17/10-59/ordered_results.RData")

bayesplot_theme_set(theme_default() + theme(text=element_text(family="sans")))


# parameter distributions

color_scheme_set("blue")
p_dists_loadings <- plot(
  b_satisfaction_outcome_results,
  pars = 1:4,
  plot.type = "areas",
  prob = 0.8,
  prob_outer = 0.95,
  point_est = "mean"
)

ggsave("../figures/ordered_outputs/mimic_loadings.png", dpi=300)

p_dists_lv_causes_enf <- plot(
  b_satisfaction_outcome_results,
  pars = 6:8,
  plot.type = "areas",
  prob = 0.8,
  prob_outer = 0.95,
  point_est = "mean"
) +
  theme(axis.text.y = element_blank()) +
  labs(title = TeX("\\textbf{Experience $\\to$ enforcement receptiveness}")) + 
  annotate(
    geom = "text", 
    x = -0.017,
    y = 3.5,
    label = "Witnessed crime",
    size = 4,
    fontface = "bold"
  ) +
  annotate(
    geom = "text", 
    x = 0.03,
    y = 2.5,
    label = " Heard via WOM\nor social media",
    size = 4,
    fontface = "bold"
  ) +
  annotate(
    geom = "text", 
    x = 0.04,
    y = 1.5,
    label = "Heard via\ntrad. media",
    size = 4,
    fontface = "bold"
  )

ggsave("../figures/ordered_outputs/mimic_exp_enf.png", dpi=300)

p_dists_lv_causes_upk <- plot(
  b_satisfaction_outcome_results,
  pars = 12:14,
  plot.type = "areas",
  prob = 0.8,
  prob_outer = 0.95,
  point_est = "mean"
) +
  theme(axis.text.y = element_blank()) +
  labs(title = TeX("\\textbf{Experience $\\to$ QI receptiveness}"))  + 
  annotate(
    geom = "text", 
    x = 0.04,
    y = 3.5,
    label = "Witnessed nuisance",
    size = 4,
    fontface = "bold"
  ) +
  annotate(
    geom = "text", 
    x = 0.033,
    y = 2.5,
    label = " Heard via WOM\nor social media",
    size = 4,
    fontface = "bold"
  ) +
  annotate(
    geom = "text", 
    x = 0.115,
    y = 1.5,
    label = "Heard via\ntrad. media",
    size = 4,
    fontface = "bold"
  )

ggsave("../figures/ordered_outputs/mimic_upk.png", dpi=300)

color_scheme_set("blue")
p_dists_lv_causes_race <- plot(
  b_satisfaction_outcome_results,
  pars = 9:11,
  plot.type = "areas",
  prob = 0.8,
  prob_outer = 0.95,
  point_est = "mean"
) + 
  theme(axis.text.y = element_blank()) +
  labs(title = TeX("\\textbf{Race $\\to$ enforcement receptiveness}")) +
  annotate(
    geom = "text", 
    x = 0.2,
    y = 3.7,
    label = "White",
    size = 4,
    fontface = "bold"
  ) + 
  annotate(
    geom = "text", 
    x = -0.01,
    y = 2.6,
    label = "Black",
    size = 4,
    fontface = "bold"
  ) + 
  annotate(
    geom = "text", 
    x = 0.2,
    y = 1.5,
    label = "Asian",
    size = 4,
    fontface = "bold"
  )

ggsave("../figures/ordered_outputs/mimic_race.png", dpi=300)


multi_mimic <- grid.arrange(
  p_dists_lv_causes_race, p_dists_lv_causes_enf, p_dists_lv_causes_upk,
  ncol = 2,
  layout_matrix = rbind(c(1, 1), c(2, 3))
)

ggsave("../figures/ordered_outputs/mimic_multi.png", plot = multi_mimic, dpi=300)

multi_mimic_cols <- grid.arrange(
  p_dists_lv_causes_race, p_dists_lv_causes_enf, p_dists_lv_causes_upk,
  ncol = 2,
  layout_matrix = cbind(c(1, 1), c(2, 3))
)

ggsave("../figures/ordered_outputs/mimic_multi_cols.png", plot = multi_mimic_cols, dpi=300)

multi_mimic_cols_flipped <- grid.arrange(
  p_dists_lv_causes_enf, p_dists_lv_causes_upk, p_dists_lv_causes_race,
  ncol = 2,
  layout_matrix = cbind(c(1, 2), c(3, 3))
)

ggsave("../figures/ordered_outputs/mimic_multi_cols_flipped.png", plot = multi_mimic_cols_flipped, dpi=300)

p_dists_lv <- plot(
  b_satisfaction_outcome_results,
  pars = 15:16,
  plot.type = "areas",
  prob = 0.8,
  prob_outer = 0.95,
  point_est = "mean"
)

ggsave("../figures/ordered_outputs/reg_lvs.png", dpi=300)

p_dists_mode <- plot(
  b_satisfaction_outcome_results,
  pars = 17:19,
  plot.type = "areas",
  prob = 0.8,
  prob_outer = 0.95,
  point_est = "mean"
)

ggsave("../figures/ordered_outputs/reg_mode.png", dpi=300)

p_dists_sociodem <- plot(
  b_satisfaction_outcome_results,
  pars = 20:23,
  plot.type = "areas",
  prob = 0.8,
  prob_outer = 0.95,
  point_est = "mean"
)

ggsave("../figures/ordered_outputs/reg_sociodem.png", dpi=300)

p_dists_exp <- plot(
  b_satisfaction_outcome_results,
  pars = 24:29,
  plot.type = "areas",
  prob = 0.8,
  prob_outer = 0.95,
  point_est = "mean"
)

ggsave("../figures/ordered_outputs/reg_exp.png", dpi=300)



# color_scheme_set("red")
# lv_asymmetry <- plot(
#   b_satisfaction_outcome_results,
#   pars = c(16, 17, 25, 26, 27, 28, 29, 30),
#   plot.type = "areas",
#   prob = 0.8,
#   prob_outer = 0.95,
#   point_est = "mean"
# ) +  
# scale_y_discrete(
#     labels = c(
#     "enforcement_sensitivity~WITNESSED_CRIME" = "Enforcement\nCrime",
#     "enforcement_sensitivity~WOM_SOC_CRIME" = "Enforcement\nWOM/Soc. Media",
#     "enforcement_sensitivity~TRAD_CRIME" = "Enforcement\nTrad. Media",
#     "upkeep_sensitivity~WITNESSED_NUIS" = "Upkeep\nNuisance"
#   )) + 
# labs(title = "Regression coefficient estimates of LVs and crime/nuisance experiences")

# ggsave("../figures/ordered_outputs/lv_reg_post.png", dpi=200)

# # indicator loadings
# color_scheme_set("blue")
# p_loadings <- plot(
#   b_satisfaction_outcome_results,
#   pars = 1:4,
#   plot.type = "areas",
#   prob = 0.8,
#   prob_outer = 0.95,
#   point_est = "mean"
# )

# ggsave("../figures/ordered_outputs/indicator_loadings.png")

# # trace plots
# #color_scheme_set("mix-blue-red")
# #p_trace <- plot(b_satisfaction_outcome_results, pars = 8:15, plot.type = "trace",
# #                n_warmup = 500,
# #                facet_args = list(ncol = 1, strip.position = "left"))

# #ggsave("../figures/ordered_outputs/regression_trace_plot.png", dpi=200)


# # posterior predictive plot
# #options(future.globals.maxSize= 891289600)
# #y <- data$satisfaction
# #ysat <- yrep[, 7]
# #ysat <- matrix(ysat, nrow=500, ncol=1799)
# #ppc_sat_dens <- ppc_dens_overlay(y, ysat[1:100,]) + 
#                 #labs(title = "Posterior predictive vs. observed satisfaction") 

# # latent variables
# lv_means_long <- pivot_longer(data.frame(posterior_lv_means), cols = 1:2, names_to = "LV", values_to = "mean")

# lv_names <- c(
#   `enforcement_sensitivity` = "Enforcement Reaction", 
#   `upkeep_sensitivity` = "Quality Improvement Reaction" 
# )

# lv_means_plot <- ggplot(data = lv_means_long, aes(x = mean, fill = LV, color = LV)) +
#                  geom_histogram(bins=15) +
#                  facet_grid(~LV, labeller = as_labeller(lv_names), scales = "free") +
#                  labs(title = "Posterior means of the latent variables") +
#                  theme(panel.background = element_rect(fill = "white"),
#                        plot.background = element_rect(fill = "white"),
#                        axis.line.x = element_line(color = "black"),
#                        axis.line.y = element_line(color = "black"),
#                        axis.text = element_text(color = "black"),
#                        text = element_text(color = "black"),
#                        panel.grid.major.y = element_blank(),
#                        legend.position = "none",
#                        strip.background = element_blank()) +
#                   scale_fill_manual(values = c("#ff8888", "#9898ff")) +
#                   scale_color_manual(values = c("red", "blue"))


# ggsave("../figures/ordered_outputs/lv_means_hist.png", width=8, height=4, dpi=250)

# lvs_and_captive <- data_with_fit_lvs %>%
#     select(UNID, num_vehicles, income, enforcement_sensitivity, upkeep_sensitivity)


# inc_veh_df <- lvs_and_captive %>% 
#                     group_by(num_vehicles, income) %>% 
#                     summarize(mean_enf = mean(enforcement_sensitivity),
#                               mean_qi = mean(upkeep_sensitivity))
                    

# inc_veh_df$income <- factor(inc_veh_df$income, levels = 1:6, labels = c("<$25k", "$25k-$50k", "$50k-$75k", "$75k-$100k", "$100k-$150k", ">$150k"))

# d <- ggplot(data = inc_veh_df, aes(x = num_vehicles, y = income, fill = mean_enf)) +
#     geom_tile() +
#     scale_fill_gradient2(low = "#900000", mid = "white", high = "#0d0d41", midpoint = 0) +
#     theme_minimal() +
#     labs(title = "Enforcement Receptiveness by Income and Number of Vehicles",
#          x = "Number of Vehicles",
#          y = "Income",
#          fill = "Enforcement\nReceptiveness"
#          ) +
#     theme(
#       axis.text = element_text(hjust = 1, size = 14), 
#       axis.title = element_text(size = 16),
#       axis.text.y = element_text(angle = 45)
#     )

# ggsave("../figures/ordered_outputs/enf_sens_inc_veh.png", dpi=300, width = 8, height = 8)

# d2 <- ggplot(data = inc_veh_df, aes(x = num_vehicles, y = income, fill = mean_qi)) +
#     geom_tile() +
#     scale_fill_gradient2(low = "#900000", mid = "white", high = "#0d0d41", midpoint = 0) +
#     theme_minimal() +
#     labs(title = "Quality Improvement Receptiveness by Income and Number of Vehicles",
#          x = "Number of Vehicles",
#          y = "Income",
#          fill = "QI Receptiveness") +
#     theme(
#       axis.text = element_text(hjust = 1, size = 14),
#       axis.title = element_text(size = 16),
#       axis.text.y = element_text(angle = 45)
#     )

# ggsave("../figures/ordered_outputs/qi_sens_inc_veh.png", dpi=300, width = 8, height = 8)

# # posterior predictive plot
# y <- data$satisfaction
# ysat <- yrep[, 7]
# ysat <- matrix(ysat, nrow=500, ncol=2093)


# ppc_sat_dens <- ppc_dens_overlay(y, ysat[1:100,]) + 
#                 labs(
#                   title = "Posterior predictive vs. observed satisfaction",
#                   x = element_text("Satisfaction"),
#                   y = element_text("Density", angle = 90)
#                 ) +  
#                 scale_color_manual(
#                   values = c("#0d0d41", "#d7d7f0"),
#                   labels = c("Observed", "Predicted")
#                 ) + 
#                 theme(
#                   legend.position = c(0.8, 0.6),
#                 ) + my_theme

# ggsave("../figures/ordered_outputs/ppc_sat_dens.png", dpi=300)

# ypred_df <- data.frame(ysat) %>% 
#   pivot_longer(cols = 1:2093, names_to = "idx", values_to = "satisfaction_pred")

# sat_df <- data %>% select(UNID, satisfaction) 

# sat_df_expanded <- sat_df[rep(1:nrow(sat_df), each = 500), ]
# sat_df_expanded <- sat_df_expanded[order(sat_df_expanded$UNID), ]

# full_sat <- cbind(sat_df_expanded, ypred_df)

# ppc_hist <- ggplot(data = full_sat) +
#               geom_histogram(aes(x = satisfaction, y = ..count../sum(..count..)), fill = "#0d0d41",  binwidth = 1) +
#               geom_density(aes(x = satisfaction_pred, group = UNID), color = alpha("#d7d7f0", 0.05)) +
#               guides(group = "none") + 
#               theme_classic() + 
#               scale_x_continuous(labels = 1:10, breaks = 1:10, limits = 1:10) + 
#               xlim(-3, 15) +
#               labs(
#                 x = "Satisfaction",
#                 y = "",
#                 title = "Posterior predictive and observed satisfaction distributions"
#               ) + 
#               theme(axis.title = element_text(size = 16),
#                     axis.text = element_text(size = 14),
#                     title = element_text(size = 16))
              

# ggsave("../figures/ordered_outputs/ppc_hist.png", dpi=300)