library(tidyverse)
temp_SBH <- read.csv("SBH_temperature - SBH_temperature.csv")
colnames(temp_SBH)[6] <- "temp"
temp_SBH
temp_95 <- temp_SBH[temp_SBH$YEAR <= 1995, ]
temp_95
winter <- temp_95[temp_95$MONTH == c(12,1,2), ]

species <- c("robin", "warbler", "cat", "dog", "komodo dragon", "python")
case_match(
  species,
  c("robin", "warbler") ~ "bird",
  c("cat", "dog") ~ "mammal",
  c("komodo dragon", "python") ~ "reptile"
)

month <- c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12")
temp_95$season <- case_match(
  temp_95$MONTH,
  c(12, 1, 2) ~ "winter",
  c(3, 4, 5) ~ "spring",
  c(6, 7, 8) ~ "summer",
  c(9, 10, 11) ~ "fall",
)
#better month to season category
month <- c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12")
temp_95$season_better <- case_match(
  temp_95$MONTH,
  c(12, 1, 2, 3, 4) ~ "winter",
  c(5, 6) ~ "spring",
  c(7, 8, 9) ~ "summer",
  c(10, 11) ~ "fall",
)
season
winter
#, "#F0E442", "#56B4E9"
View(temp_SBH)
season_colors <- c("#E69F00", "#009E73", "#DD4444", "#0072B2")

ggplot(temp_SBH, aes(x= YEAR, y = temp, color = MONTH)) +
  geom_point() +
  theme_bw() +
  labs (x = "Year",
        y = "Temp (C)")

ggplot(temp_95, aes(x= YEAR, y = temp, color = season)) +
  geom_point() +
  theme_bw() +
  labs (x = "Year",
        y = "Temp (C)") +
  scale_color_manual(values = season_colors)
ggsave("temp_95_seasons.png")
