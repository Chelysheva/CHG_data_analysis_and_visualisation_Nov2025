##Breakout tasks - MSD COVID dataset

#Q1) Import the corresponding sheet from Excel file provided (use readxl)
#Group 1 - IFNy; Group 2 - IL-1; Group 3 - IL-2
library(readxl)
mydata <- read_excel("Session1/data/MSD_data.xlsx", sheet = 'IL-1')
mydata$Randomised_to <- as.factor(mydata$Randomised_to)
levels(mydata$Randomised_to)

#Q2) Add a new column "Subtraction" (col4) by subtracting the background unstimulated value (col3) from the stimulated one (col2)
library(dplyr)
#with base R
mydata$Subtraction <- mydata$Calc.Conc.Mean_S1S2-mydata$Calc.Conc.Mean_Unst
#or with dplyr
mydata %>% mutate(Subtraction=Calc.Conc.Mean_S1S2-Calc.Conc.Mean_Unst) -> mydata

#Q3) Group the "Subtraction" values by the randomisation group and find mean, median, standard deviation
mydata %>% group_by(Randomised_to) -> mydata1
summarise(mydata, median(Subtraction))
summarise(mydata1, median(Subtraction))
#Note the difference?

#Q4) Find the maximum and minimum values of Subtract in each group (group by randomisation)
mydata %>% group_by(Randomised_to) %>% summarise(min(Subtraction),max(Subtraction))

#Q5) Remove the rows, which have negative values in Subtract
#with base R
mydata <- mydata[mydata$Subtraction>0,]
#or with dplyr
mydata %>% filter(Subtraction>0) -> mydata

#Q6) Save the table as csv comma-separated file containing columns 1, 5 and 6 only (without negative values - see #5)
#with base R
mydata <-mydata[,c(1,5,6)]
#or with dplyr
mydata %>% select(Participant_ID,Randomised_to,Subtraction) -> mydata
#write a result
write.csv(mydata,"my_final_MSD_data.csv")