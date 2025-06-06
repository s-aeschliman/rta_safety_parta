sample_df <- read_csv("../data/data_for_sem.csv")
df_p <- read_csv("../data/cmap/person.csv") %>% filter(age >= 18)
df_hh <- read_csv("../data/cmap/household.csv")
2
print(unique(sample_df$num_vehicles))

df_hh$inc_rta <- ifelse(df_hh$hhinc < 0, NA, 
                        ifelse(df_hh$hhinc <=2, "Under $25k",
                               ifelse(df_hh$hhinc <=5, "$25k-$49k",
                                      ifelse(df_hh$hhinc <=7, "$50k-$74kk",
                                             ifelse(df_hh$hhinc == 8, "$75k-$99k",
                                                    ifelse(df_hh$hhinc == 9, "$100k-149k", "$150k+"))))))

df_p$age_rta <- ifelse(df_p$age < 0, NA, 
                        ifelse(df_p$age <= 24, "Under 25",
                               ifelse(df_p$age <= 44, "25-44",
                                      ifelse(df_p$age <= 54, "45-54",
                                             ifelse(df_p$age <= 64, "55-64", "Over 65")))))

df_p$race_white <- ifelse(df_p$race == 1, 1, 0)
df_p$race_black <- ifelse(df_p$race == 2, 1, 0)
df_p$race_asian <- ifelse(df_p$race == 3, 1, 0)
df_p$race_other <- ifelse(df_p$race >= 4, 1, 0)

df_p$gender_rta <- ifelse(df_p$sex < 1, NA, 
                        ifelse(df_p$sex == 1, "Male", "Female"))

df_hh$hhveh_rta <- ifelse(df_hh$hhveh < 0, NA, 
                        ifelse(df_hh$hhveh == 0, 0,
                               ifelse(df_hh$hhveh == 1, 1,
                                      ifelse(df_hh$hhveh == 2, 2, 3))))

print(length(df_p$gender_rta))
print(table(df_p$gender_rta)/length(df_p$gender_rta))
print(length(df_p$age_rta))
print(table(df_p$age_rta)/length(df_p$age_rta))
print(length(df_hh$inc_rta))
print(table(df_hh$inc_rta)/length(df_hh$inc_rta))
print(length(df_hh$hhveh_rta))
print(table(df_hh$hhveh_rta)/length(df_hh$hhveh_rta))
print(length(df_p$race_white))
print(table(df_p$race_white)/length(df_p$race_white))
print(table(df_p$race_black)/length(df_p$race_black))
print(table(df_p$race_asian)/length(df_p$race_asian))
print(table(df_p$race_other)/length(df_p$race_other))
