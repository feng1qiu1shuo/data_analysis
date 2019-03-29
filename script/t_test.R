#! /usr/bin/env Rscript
#load packages
library(tidyverse)
library(ggpubr)
library(ggplot2)
library(reshape2)

#import data(the file should not include any unneccesary whitespace)
import_data <- read.table("data/Ricco_data.csv",header = T, sep = "", stringsAsFactors = F)
import_data   #have a look

#get basic summary of the data
group_by(import_data, sample) %>%
  summarise(
    count = n(),
    mean = mean(myrcene, na.rm = TRUE),
    sd = sd(myrcene, na.rm = TRUE)
  )

summary(import_data)

#first visulization
ggboxplot(import_data, x = "sample", y = "myrcene", 
          color = "sample", palette = c("blue", "yellow","black", "red"),
          ylab = "conc", xlab = "sample")

#t-test requires assumptions: data follow normol distribution (if sample size>30, usually do not need check this as the central limit theorem)
shapiro.test(import_data$myrcene)   #as p>0.05, so it is normal distributed
#or can be check visulizely
ggqqplot(import_data$myrcene, ylab = "conc",
         ggtheme = theme_minimal())

#t-test option: paired or unpaired(default), assuming equal variance or without assuming equal variance(default), two sample(default) or one sample, two side(defult) or one side
#defult t-test: unpaired, without assuming equal variance, two sample, two sided
t.test(formula = myrcene ~ sample,
       data = import_data,
       subset = sample %in% c("C", "ED"))
#or as simple as below, below is exactly the same as above
t.test(myrcene ~sample, import_data, sample %in%c("C", "ED"))

#paired t-test
t.test(myrcene ~sample, import_data, sample %in%c("C", "ED"), paired = TRUE)

#assuming equal variace
t.test(myrcene ~sample, import_data, sample %in%c("C", "ED"), var.equal = T)

#one sample two sided
t.test(mu =0, import_data$myrcene)

#one sample one sided (less or greater)
t.test(mu =0, import_data$myrcene, alternative = "greater")




