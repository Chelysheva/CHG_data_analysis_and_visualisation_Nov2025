###Data analysis and visualisation
##Dr Irina Chelysheva
##26.03.2025

##Breakout tasks - MSD COVID dataset
#1) Import the corresponding sheet from Excel file provided (use readxl)
#Group 1 - IFNy; Group 2 - IL-1; Group 3 - IL-2; Group 4 - IL-10
library(readxl)
MSD_data <- read_excel("Session1/data/MSD_data.xlsx", 
                        sheet = 4)
#2) Add a new column "Subtraction" (col6) by subtracting the background unstimulated value (col4) from the stimulated one (col3)
MSD_data$Subtraction=MSD_data$Calc.Conc.Mean_S1S2-MSD_data$Calc.Conc.Mean_Unst
MSD_data %>%
  mutate(Subtraction=Calc.Conc.Mean_S1S2-Calc.Conc.Mean_Unst) -> MSD_data
#3) Group the "Subtraction" values by the randomisation group (col5) and find mean, median, standard deviation
MSD_data %>%
  group_by(Randomised_to) %>%
  summarise(mean=mean(Subtraction),median=median(Subtraction),sd=sd(Subtraction))
#4) Find the maximum and minimum values of col6 in each group (group by col5)
MSD_data %>%
  group_by(Randomised_to) %>%
  summarise(min=min(Subtraction),max=max(Subtraction))
summary(MSD_data)
#5) Remove the rows, which have negative values in col6
MSD_data %>%
  filter(Subtraction>=0) -> MSD_data
#6) Save the table as csv (comma-separated) file containing columns 1, 2, 5 and 6 only (without negative values - see #5)
MSD_data %>% select(Participant_ID,Assay,Subtraction,Randomised_to) %>%
write.csv("MSD_selected.csv")

MSD_data %>% select(Participant_ID,Assay,Subtraction,Randomised_to) ->MSD_data_selected

write.csv(MSD_data_selected, "MSD_selected.csv")

MSD_data[ , c(1,2,5,6)] -> MSD_data_selected_baseR

colnames(MSD_data_selected)<-c("ID","Cytokine","Value","Randomisation")
