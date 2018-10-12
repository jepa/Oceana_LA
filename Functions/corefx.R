# Juliano Palacios | j.palacios@oceans.ubc.ca
# This function estimates the National seafood supply from a series of equations developed for the Oceana project.


####Variables ####
# Species = Name of species 
# Country = Country in question
# Catch = Fisheries Landings
# Dis = Discards lost at sea
# DHC = Proportion of the landings that go to direct human consumption
# PL = Proportion lost in processing DHC
# AP = Aquaculture production
# A_PL = Proportion lost in processing aquaculture (Can use same as wild fish, Muhammed pers. comm.)
# I_DHC = Imports to direct human consumtion
# Exp = Exports
# Results = Two options; T will return a table with the values and P will return a boxplot
# n = the number of species you want to return


#### The Function ####

corefx <- function(
  Species,
  Country,
  Catch,
  Dis,
  DHC,
  PL,
  AP,
  A_PL,
  I_DHC,
  Exp,
  Result = "T",
  n = 5
){
  
  #### Variables ####
  
  # First Step 
  TDS <- Catch*Dis #TDS (Total Discards) Discarded fish before landings
  LS <- Catch - TDS # LS Landings supply after discards at see
  
  # Second Step
  IHC <- LS * (1-DHC) # (Indirect Human Consumption) Landings supply that does NOT go to DHC
  SHC <- LS - IHC # (Supply for Human Consumption) Landings supply that goes to DHC
  
  # Third Step
  LP <- SHC * PL # Fish lost in processing 
  LHC <- SHC - LP # Final landings after processing losses 
  
  # Fourth Step (Aquaculture)
  AIHC <- AP * A_PL # (Aquaculture indirect human Consumption) Lost of aquaculture processing
  AHC <- AP - AIHC # (Aquaculture Human Consumption) Aquaculure human Consumption
  
  # Fifth Step (Trade)
  NI <- I_DHC - Exp # Net Imports
  
  
  # Final step
  NSP <- LHC + AHC + NI # (National Seafood Supply) 
  TIHC <- IHC + AIHC # Total IHC fishmeal fishoil
  
  
  #### Table option ####
  Result_Table <- data.table(
    "Specie" = Species,
    "Country" = Country,
    "Landings Food Supply" = LHC,
    "Aquaculutre Food Supply" = AHC,
    "Net Imports" = NI,
    "National Seafood Supply" = NSP
  )
  
  #### Graphic option ####
  Result_Table <- Result_Table %>% 
    gather("Variable","Value",3:6) %>%
    group_by(Country,Variable) %>% 
    top_n(n = 5, wt = Value)
  
  Plot <- Result_Table %>% 
    ggplot(.,
           aes(
             x= Specie,
             y = Value/1000,
             fill = Variable
           )
    ) +
    geom_bar(stat = "identity") +
    geom_label_repel(data = Result_Table,
                     aes(
                       x= Specie,
                       y = (Value-(Value*.10))/1000,
                       label = as.factor(round((Value-(Value*.10))/1000))
                     ),
                     show.legend = FALSE
    ) +
    ylab("Thousand Tonnes") +
    facet_wrap(~Country)
  
  # Function result ####
  if(Result == "T"){
    return(Result_Table)
  }
  
  if(Result == "P") {
    return(Plot)
  }
  
}



#### Testing ####

corefx(
  Species = "Julianus",
  Country = "Chile",
  Catch = 500,
  Dis = .9,
  DHC = 0.9,
  PL = 0.2,
  AP = 0,
  A_PL = 0.2,
  I_DHC = 0,
  Exp = 10,
  Result = "P",
  n = 5
)

