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
    "Landings Food Supply" = round(LHC,2),
    "Aquaculutre Food Supply" = round(AHC,2),
    "Net Imports" = round(NI,2),
    "National Seafood Supply" = round(NSP,2)
  ) %>% 
    mutate(
      Warning = ifelse(Exp > LA_HC,"*","")
    )
  
  #### Graphic option ####
  Plot_Table <- Result_Table %>% 
    gather("Variable","Value",3:6) %>%
    group_by(Country,Variable) %>% 
    top_n(n = 5, wt = Value)
  
  Plot <- Plot_Table %>% 
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
  
  if(Result == "B") {
    Plot
    return(Result_Table)
    
  }
  
}



#### Testing ####

# corefx(
#   Species = "Julianus",
#   Country = "Chile",
#   Catch = 500,
#   Dis = .9,
#   DHC = 0.9,
#   PL = 0.2,
#   AP = 0,
#   A_PL = 0.2,
#   I_DHC = 0,
#   Exp = 10,
#   Result = "P",
#   n = 5
# )


# International_Data <- read.csv("~/Documents/Github/Oceana_LA/clean_databases/International/International_Data.csv")
# View(International_Data)
# 
# International_Data <- International_Data[1:2,1:12]
# 
# Country=International_Data$Country
# Species = International_Data$Comm.Name
# Catch = International_Data$Capture
# Dis = 0.20
# DHC = International_Data$DHC_Use
# PL = 0.20
# AP = International_Data$Aquaculture
# A_PL = 0.20
# I_DHC = International_Data$Imports
# Exp = International_Data$Exports
# 
# 
# x <-corefx(
#   Country=International_Data$Country,
#   Species = International_Data$Comm.Name,
#   Catch = International_Data$Capture,
#   Dis = 0.20,
#   DHC = International_Data$DHC_Use,
#   PL = 0.20,
#   AP = International_Data$Aquaculture,
#   A_PL = 0.20,
#   I_DHC = International_Data$Imports,
#   Exp = International_Data$Exports,
#   Result = "B",
#   n = 5
# )

