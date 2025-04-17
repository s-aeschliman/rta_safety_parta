library(rstan)
options(mc.cores = parallel::detectCores())
load("lavExport/semstan.rda")

stan_data <- stantrans$data

fit <- stan(
    file = "lavExport/sem.stan",
    data = stan_data,
    pars = stantrans$monitors,
    chains = 4,
    warmup = 500,
    iter = 1000,
    cores = 4
)

print(fit)