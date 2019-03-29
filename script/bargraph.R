#! /usr/bin/env Rscript
#load packages
library(tidyverse)
library(ggpubr)
library(ggplot2)
library(reshape2)

tooth_growth <- read.table('guinea_pigs_tooth_growth.txt',header = TRUE)  #read table

tooth_growth$dose <- as.factor(tooth_growth$dose) # Convert dose to a factor variable

#define a function to get mean and sd of several groups
#varname is the name of a column containing the variable to be summariezed
#groupnames is the vector of column names to be used as grouping variables
data_summary <- function(data, varname, groupnames){ 
  require(plyr)
  data_sum<-ddply(data, groupnames,                  
                  .fun = function(x, col){            
                    c(mean = mean(x[[col]], na.rm=TRUE),
                      sd = sd(x[[col]], na.rm=TRUE)
                    )
                  },
                  varname)  
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
  labs(title="The effect of vitmin C on guinea pigs tooth growth", 
       x="Dose (mg/day)", y = "Length")+
  theme_classic() +
  scale_fill_manual(values=c('#000000','#FFFFFF'))   #define lable, title, colour