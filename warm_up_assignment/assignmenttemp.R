library(tidyverse) #load tidyverse
library(scales) #for percent() function
titanic <- data.frame(Titanic) #store in variable titanic as dataframe 


child <- titanic %>% filter(Age == "Child") %>% select(Freq) %>% sum()  #sum of all children
adult <- titanic %>% filter(Age == "Adult") %>% select(Freq) %>% sum()  #sum of all adults
sprintf('There are %d children and %d adults', child, adult) #print results

adult_male <- titanic %>% filter(Age == "Adult" & Sex == "Male") %>% select(Freq) %>% sum()  #sum of all adult males
adult_female <- titanic %>% filter(Age == "Adult" & Sex == "Female") %>% select(Freq) %>% sum()  #sum of all adult female
if (adult_male > adult_female){
  sprintf('More male adult passengers (%d) than female adult passengers (%d)' , adult_male, adult_female)
} else {
  sprintf('More female adult passengers (%d) than male adult passengers (%d)' , adult_female, adult_male)  
}     #compare male and female number and print results

child_survived <- titanic %>% filter(Age == "Child" & Survived == "Yes") %>% select(Freq) %>% sum()  #sum of all survived children
child_survival_rate <- child_survived/child    #calculate children survival rate
adult_survived <- titanic %>% filter(Age == "Adult" & Survived == "Yes") %>% select(Freq) %>% sum() #sum of all survived adults
adult_survival_rate <- adult_survived/adult   #calculate adults survival rate
if (child_survival_rate > adult_survival_rate){
  sprintf('Children (%s) have better survival rate than adults (%s)' , percent(child_survival_rate), percent(adult_survival_rate))
} else {
  sprintf('Children (%s) do not have better survival rate than adults (%s)' , percent(child_survival_rate), percent(adult_survival_rate))
}       #compare children and adults survival rates and print results


survival_rate <- c()  #define SurvivalRate as an empty vector
for (i in c("Crew", "1st", "2nd", "3rd")){
  survived <- titanic %>% filter(Class == i & Survived == "Yes") %>% select(Freq) %>% sum()    
  all <- titanic %>% filter(Class == i) %>% select(Freq) %>% sum() 
  survival_rate <- c(survival_rate, survived/all)
}   #calculate the survival rate for each class in the order of crew, 1st, 2nd, 3rd
names(survival_rate) <- c("Crew", "1st", "2nd", "3rd")  #name the vector in the order of Crew, 1st, 2nd, 3rd
survival_rate <- c(sort(survival_rate, decreasing = TRUE))  #sort the vector accoording to survival rate from highest to lowest
sprintf('%s (%s) have better survival rate, followed by %s (%s), %s (%s), %s (%s)', names(survival_rate)[1], percent(survival_rate[1]), 
        names(survival_rate)[2],percent(survival_rate[2]),names(survival_rate)[3],percent(survival_rate[3]),names(survival_rate)[4], percent(survival_rate[4]))
          #print reslults


tooth_growth <- read.table('guinea_pigs_tooth_growth.txt',header = TRUE)  #read table

tooth_growth$dose <- as.factor(tooth_growth$dose) # Convert dose to a factor variable

data_summary <- function(data, varname, groupnames){  #define a function to get mean and sd of several groups by groupnames
  require(plyr)
  data_sum<-ddply(data, groupnames,                   #varname is the name of a column containing the variable to be summariezed
                  .fun = function(x, col){            #groupnames is the vector of column names to be used as grouping variables
                    c(mean = mean(x[[col]], na.rm=TRUE),
                      sd = sd(x[[col]], na.rm=TRUE)
                      )
                    },
                  varname)    #
  data_sum <- rename(data_sum, c("mean" = varname)) # rename the "mean" with varname
  return(data_sum)
}

tooth_growth_summary<- data_summary(ToothGrowth, varname="len", 
                    groupnames=c("supp", "dose"))     #apply data_summary function to get mean and sd by supp and dose grouping

tooth_growth_summary$dose=as.factor(tooth_growth_summary$dose) # Convert dose to a factor variable


ggplot(tooth_growth_summary, aes(x=dose, y=len, fill=supp)) +      
  geom_bar(stat="identity", color="black", position=position_dodge()) +  #create bar plot
  geom_errorbar(aes(ymin=len, ymax=len+sd), width=.2,    
                position=position_dodge(.9)) +              #add error bar
  labs(title="The response of guinea pigs odontoblasts to vitmin C supply", x="Dose (mg/day)", y = "Length")+
  theme_classic() +
  scale_fill_manual(values=c('#000000','#FFFFFF'))   #define lable, title, colour

