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

corefx_flow <- function(
  Species,
  Country,
  Catch,
  Dis,
  DHC,
  PL,
  AP,
  A_PL,
  I_DHC,
  Exp
){
  
  #### Variables ####
  
  # First Step 
  TDS <- Catch*Dis #TDS (Total Discards) Discarded fish before landings
  LS <- Catch - TDS # LS Landings supply after discards at see
  
  ## Rules for NA values
  LS <- ifelse(is.na(LS),TDS,LS) # If no discard data then LS becomes catch
  
  # Second Step
  IHC <- LS * (1-DHC) # (Indirect Human Consumption) Landings supply that does NOT go to DHC
  SHC <- LS - IHC # (Supply for Human Consumption) Landings supply that goes to DHC
  
  ## Rules for NA values
  SHC <- ifelse(is.na(SHC),LS,SHC) # If no IHC/DHC data then SHC becomes LS (assuming everything goes to DHC)
  
  # Third Step
  LP <- SHC * PL # Fish lost in processing 
  LHC <- SHC - LP # Final landings after processing losses 
  
  ## Rules for NA values
  LHC <- ifelse(is.na(LHC),SHC,LHC) # If no processing values data then LHC becomes SHC
  
  
  # Fourth Step (Aquaculture)
  
  AIHC <- AP * A_PL # Lost of aquaculture processing
  AHC <- AP - AIHC # (Aquaculture Human Consumption) Aquaculure human Consumption
  
  ## Rules for NA values
  AHC <- ifelse(is.na(AHC),AP,AHC) # If no discard data then AHC becomes AP
  
  
  
  # Fifth Step (Trade)
  NI <- I_DHC - Exp # Net Imports
  
  
  # Final step
  
  ## Rules for NAs
  LHC <- ifelse(is.na(LHC),0,LHC)
  AHC <- ifelse(is.na(AHC),0,AHC)
  NI <- ifelse(is.na(NI),0,NI)
  
  ## Results
  LA_HC <- LHC + AHC # Whats produced in the country
  NSP <- LHC + AHC + NI # (National Seafood Supply) 
  TIHC <- sum(IHC, AIHC, na.rm =T) # Total IHC fish meal fish oil
  
  
  #### Frequencies ####
  
  # hist(NSP)
  
  
  
  #### Table option ####
  Result_Table <- data.table(
    "Specie" = Species,
    "Country" = Country,
    # "Catch" = Catch,
    # "Aquaculutre" = AP,
    "Imports" = I_DHC,
    "National Seafood Supply" = round(NSP,2),
    "Total_Discards" = round(TDS,2),
    "Not_Discards" = LS,
    "I_HC" = round(IHC,2),
    "DHC" = SHC,
    "Lost_Processing" = round(LP,2),
    "Not_lost" = LHC,
    "Aqua_Lost_Processing" = round(AIHC,2),
    "Aqua_HC" = AHC,
    "Exports" = Exp #,
    # "Net_Imp" = NI
  ) %>% 
    mutate(
      Warning = ifelse(Exp > LA_HC,"*","")
    )
  
  
  # Function result ####
  
    return(Result_Table)
}
