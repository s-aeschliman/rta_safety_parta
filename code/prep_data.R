
library(tidyverse)

setwd("/Users/aesch/Documents/Grad School/projects_grad/rta/safety study/code")

# raw data set 
full_sat_data <- read_csv("../raw/wave_8.csv") %>% select(-c(FREQ8, MODE8, MODE, GENDRN, AGEGRN, HHVEHN, INC4WGTN, PURP8, TRNST_LYLTY))

# fix the satisfaction column (1 and 10 are character strings for some reason)
full_sat_data$CSS_3_OVSAT[full_sat_data$CSS_3_OVSAT == "Very Dissatisfied1"] <- 1
full_sat_data$CSS_3_OVSAT[full_sat_data$CSS_3_OVSAT == "Very Satissfied10"] <- 10
full_sat_data$satisfaction <- as.numeric(full_sat_data$CSS_3_OVSAT)

sathist <- ggplot(full_sat_data, aes(x = satisfaction)) + 
           geom_histogram(binwidth = 1, fill = "blue") +
           labs(title = "Satisfaction Histogram", x = "Satisfaction", y = "Frequency")


# add crime/nuisance experience variables to the data set
crime_experiences <- full_sat_data %>% select(matches("_EXP_.*_1$")) %>% select(matches("WIT|WOM|TRADN|IDKNO"))
crime_experiences[!is.na(crime_experiences)] <- "1"
crime_experiences <- mutate_all(crime_experiences, function(x) as.numeric(as.character(x)))

# crimes
crime_experiences$WITNESSED_CRIME <- do.call(coalesce, crime_experiences %>% select(matches("(ASS|HARS|ROB)_WIT")))
crime_experiences$WOM_SOC_CRIME <- do.call(coalesce, crime_experiences %>% select(matches("(ASS|HARS|ROB)_WOM")))
crime_experiences$TRAD_CRIME <- do.call(coalesce, crime_experiences %>% select(matches("(ASS|HARS|ROB)_TRADN")))
crime_experiences$IDK_CRIME <- do.call(coalesce, crime_experiences %>% select(matches("(ASS|HARS|ROB)_IDKNO")))

# nuisances
crime_experiences$WITNESSED_NUIS <- do.call(coalesce, crime_experiences %>% select(matches("(NOISE|SUBUSE|HMLSS|DAM|DIRT)_WIT")))
crime_experiences$WOM_SOC_NUIS <- do.call(coalesce, crime_experiences %>% select(matches("(NOISE|SUBUSE|HMLSS|DAM|DIRT)_WOM")))
crime_experiences$TRAD_NUIS <- do.call(coalesce, crime_experiences %>% select(matches("(NOISE|SUBUSE|HMLSS|DAM|DIRT)_TRADN")))
crime_experiences$IDK_NUIS <- do.call(coalesce, crime_experiences %>% select(matches("(NOISE|SUBUSE|HMLSS|DAM|DIRT)_IDKNO")))

# NAs are automatically there for modes they didn't take due to branching in the survey. otherwise, NA means "not true", so OK to replace NAs with zeros
crime_experiences$WITNESSED_CRIME <- crime_experiences$WITNESSED_CRIME %>% replace_na(0)
crime_experiences$WOM_SOC_CRIME <- crime_experiences$WOM_SOC_CRIME %>% replace_na(0)
crime_experiences$TRAD_CRIME <- crime_experiences$TRAD_CRIME %>% replace_na(0)
crime_experiences$IDK_CRIME <- crime_experiences$IDK_CRIME %>% replace_na(0)
crime_experiences$WITNESSED_NUIS <- crime_experiences$WITNESSED_NUIS %>% replace_na(0)
crime_experiences$WOM_SOC_NUIS <- crime_experiences$WOM_SOC_NUIS %>% replace_na(0)
crime_experiences$TRAD_NUIS <- crime_experiences$TRAD_NUIS %>% replace_na(0)
crime_experiences$IDK_NUIS <- crime_experiences$IDK_NUIS %>% replace_na(0)

# discard the vars we were using to coalesce
crime_experiences <- crime_experiences %>% select(
  WITNESSED_CRIME, WITNESSED_NUIS,
  WOM_SOC_CRIME, TRAD_CRIME, IDK_CRIME,
  WOM_SOC_NUIS, TRAD_NUIS, IDK_NUIS
)

full_sat_data <- cbind(full_sat_data, crime_experiences)

# run the python script to recode some variables
# saves to ../data/recoded_<var_types>.csv
# (haven't transferred over to R yet...)
system("python3 raw_recoding.py")

# recode more/less safe variables
more_safe <- read_csv("../data/recoded_more_safe.csv") %>% select(-UNID)

more_safe$MORE_SAFE_POLICE <- do.call(coalesce, more_safe %>% select(matches("POLICE")))
more_safe$MORE_SAFE_PSEC <- do.call(coalesce, more_safe %>% select(matches("PSEC")))
more_safe$MORE_SAFE_K9 <- do.call(coalesce, more_safe %>% select(matches("K9")))
more_safe$MORE_SAFE_SW <- do.call(coalesce, more_safe %>% select(matches("SW")))
more_safe$MORE_SAFE_LIGHT <- do.call(coalesce, more_safe %>% select(matches("LIGHT")))
more_safe$MORE_SAFE_CLEAN <- do.call(coalesce, more_safe %>% select(matches("CLEAN")))
more_safe$MORE_SAFE_CROWD <- do.call(coalesce, more_safe %>% select(matches("CROWD")))
more_safe$MORE_SAFE_FREQ_REL <- do.call(coalesce, more_safe %>% select(matches("FREQ_REL")))

more_safe <- more_safe %>% select(
  MORE_SAFE_POLICE,
  MORE_SAFE_PSEC,
  MORE_SAFE_K9,
  MORE_SAFE_SW,
  MORE_SAFE_LIGHT,
  MORE_SAFE_CLEAN,
  MORE_SAFE_CROWD,
  MORE_SAFE_FREQ_REL
)

full_sat_data <- cbind(full_sat_data, more_safe)

recoded_dems <- read.csv("../data/recoded_dem_data.csv")

full_sat_data <- cbind(full_sat_data, recoded_dems) %>% select(-X, -...1)


# rename the columns we are going to use
full_sat_data <- full_sat_data %>% 
  rename(
    frequency = FREQ8,
    mode = MODE,
    gender = GENDRN,
    gender_Female = GENDRN_Female,
    age = AGEGRN, 
    num_vehicles = HHVEHN, 
    income = INC4WGTN,
    region = REGIONN,
    race = RACE4WGTN
  )

full_sat_data$age

sem_data <- full_sat_data %>% select(
  UNID,
  gender,
  gender_Female,
  age,
  num_vehicles,
  income,
  race,
  mode,
  region,
  satisfaction,
  matches("^MORE_SAFE"),
  matches("_CRIME$"),
  matches("_NUIS$")
) %>% drop_na()

sem_data <- fastDummies::dummy_cols(sem_data, select_columns = "region")
sem_data <- fastDummies::dummy_cols(sem_data, select_columns = "mode")
sem_data <- fastDummies::dummy_cols(sem_data, select_columns = "race")

write_csv(sem_data, "../data/data_for_sem.csv")

# stats for table in paper

dsize <- nrow(sem_data)

summary_female <- sem_data %>% count(gender_Female) %>% mutate(pct = n / dsize)
summary_age <- sem_data %>% count(age) %>% mutate(pct = n / dsize)
summary_num_vehicles <- sem_data %>% count(num_vehicles) %>% mutate(pct = n / dsize)
summary_income <- sem_data %>% count(income) %>% mutate(pct = n / dsize)

sem_data %>% count(gender_Female) %>% mutate(pct = n / sum(n))
sem_data %>% count(age) %>% mutate(pct = n / sum(n))
sem_data %>% count(income) %>% mutate(pct = n / sum(n))
sem_data %>% count(num_vehicles) %>% mutate(pct = n / sum(n))
sem_data %>% count(race) %>% mutate(pct = n / sum(n))

sem_data %>% count(WITNESSED_CRIME) %>% mutate(pct = n / sum(n))
sem_data %>% count(WITNESSED_NUIS) %>% mutate(pct = n / sum(n))
sem_data$witnessed_any <- ifelse(sem_data$WITNESSED_CRIME == 1 | sem_data$WITNESSED_NUIS == 1, 1, 0)
sem_data %>% count(witnessed_any) %>% mutate(pct = n / sum(n))

mean(full_sat_data$satisfaction)
sd(full_sat_data$satisfaction)
mean(sem_data$satisfaction)
sd(sem_data$satisfaction)