library(bayesplot)
library(tidyverse)

load("saved_models/safety_bsem_continuous_2025-04-16_18-54.RData")
#coef(b_satisfaction_outcome_results_ordered)
#print(effective_sample_sizes)

# pairplots (checking for large correlations or multi-modality)
pair_plots <- plot(
    b_satisfaction_outcome_results_continuous,
    pars = 15:18,
    plot.type = "pairs"
) + stat_density_2d()

ggsave("../figures/diagnostics/pair_plots_continuous.png", dpi=300, width = 8, height = 8)

# trace plots 
trace_plots <- plot(
    b_satisfaction_outcome_results_continuous,
    pars = 15:29,
    plot.type = "trace"
)

ggsave("../figures/diagnostics/trace_plots_continuous.png", dpi=300, width = 16, height = 8)

ess_df <- data.frame(
    param = names(effective_sample_sizes),
    ess = effective_sample_sizes
)

ess_barplot <- ggplot(ess_df, aes(x = reorder(param, ess), y = ess)) +
    geom_bar(stat = "identity", fill = "#97daf0") +
    coord_flip() +
    scale_x_discrete(labels = rep("", length(effective_sample_sizes))) +
    theme_minimal() +
    geom_hline(yintercept = 100*num_chains, linetype = "dashed", color = "#000274") +
    theme(
        panel.grid.major = element_blank(),
        axis.line.x = element_line(color = "black"),
        axis.line.y = element_line(color = "black"),
        axis.ticks.x = element_blank()
    ) +
    labs(
        title = "Effective Sample Sizes",
        x = "Sorted model parameters",
        y = "Effective Sample Size"
    )

ggsave("../figures/diagnostics/ess_barplot_continuous.png", dpi=300, width = 8, height = 8)