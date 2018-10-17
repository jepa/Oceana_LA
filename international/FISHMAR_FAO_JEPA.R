
library(dplyr)

#### FAO's Data ####

FAO_Data <- read.csv("./FAO_Data.csv")

#### FISHMAR Data ####

FISHMAR <- read.csv("./FISHMAR_data") %>% 
  rename(Group = Commodity) # # Rename FISHMAR to mach FAO data


#### Total number of commodities and per country in FAO data####

# Total 

length(unique(FAO_Data$Group)) #472

# For one specific year... 
FAO_Data %>%
  filter(Year == "X2014") %>%
  group_by(Country,Unit) %>%
  summarise(n())

# 290 Brasil
# 402 Chile-le
# 244 Peru

#### Number of commodities per country in FISHMAR data####

length(unique(FISHMAR$Group)) # 363 vs 472 of FAO = 77%

FISHMAR %>% 
  group_by(Country) %>% 
  summarise(n())

# Comodities per country in FISHMAR
# Brazil 243 vs 290 of FAO = 83%
# Chile 407 vs 407 of FAO = 100%
# Peru 179 vs 244 of FAO = 73%


# Number of commodities in FAO data and FISHMAR data are very similar, however, when we try to match them FISHMAR's dataset only maches the FAO data in 32.24%

# #### Comparing datasets by Trade Group ####

FAO_Group <- FAO_Data %>% 
  group_by(Group) %>% 
  summarise(n())

Semi_FAO_FISHMAR <- FAO_Group %>%
  semi_join(FISHMAR,
            by = "Group") # 153 out of 472 comodities matched = 32.4%
# 
# unique(Semi_FAO_FISHMAR$Group)

# # What in FAO is NOT represented in Alfredo's data
Anti_FAO_FISHMAR <- FAO_Group %>%
  anti_join(Clean_FISHMAR,
            by = "Group") # 319 out of 472 comodities = 67.6% missmatched...
