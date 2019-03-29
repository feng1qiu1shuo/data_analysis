#! /usr/bin/env Rscript
#this script for one-way and two-way anova analysis
#load packages
library(tidyverse)
library(ggpubr)
library(ggplot2)
library(reshape2)
library(car)

#import data(the file should not include any unneccesary whitespace)
import_data <- read.table("data/Ricco_data.csv",header = T, sep = "", stringsAsFactors = T)
import_data   #have a look

#check the level of factors are in right order or not
levels(import_data$sample)
#if not, reorder it, in this case, "C" will be the base during following one-way anova test
import_data$sample <- ordered(import_data$sample,
                              levels = c("C", "ED", "LD", "PD"))

#get basic summary of the data
group_by(import_data, sample) %>%
  summarise(
    count = n(),
    mean = mean(linalool, na.rm = TRUE),
    sd = sd(linalool, na.rm = TRUE)
  )

summary(import_data)

#first visulization
ggboxplot(import_data, x = "sample", y = "linalool", 
          color = "sample", palette = c("blue", "yellow","black", "red"),
          ylab = "conc", xlab = "sample")

ggline(import_data, x = "sample", y = "linalool", 
       add = c("mean_se", "jitter"), 
       ylab = "conc", xlab = "sample")


#before analysis, assumptions should be checked, but some packages need anova results first, so we de anova first
#perform one-way anova
res.aov <- aov(linalool ~ sample, import_data)
summary(res.aov)   #p > 0.05, overall the treatment did not cause difference. 


#if above result is significant, we need to know which treatments are significant, use Tukey multiple pairwise-comparisons
TukeyHSD(res.aov)
#or by pairewise.t.test() to calculate pairwise comparisons between group levels with corrections for multiple testing.
pairwise.t.test(import_data$linalool, import_data$sample,
                p.adjust.method = "BH")

#check assumption now
# check normality, if p > 0.05, ok
aov_residuals <- residuals(object = res.aov )
shapiro.test(x = aov_residuals )
#or by graphing, if all the points fall approximately along this reference line, we can assume normality.
plot(res.aov, 2)

#hcheck homogeneity of variance, if p>0.05, it is ok for next step
leveneTest(linalool ~ sample, data = import_data)
#or by graphing. if the mean of each group is similar, it is ok for next
plot(res.aov, 1)
#if data cannot meet requirment, we still can do  Welch one-way test), that does not require that assumption have been implemented in the function oneway.test().
oneway.test(linalool ~ sample, data = import_data)


#now two-way anova
res_twoway_aov <- aov(linalool ~ sample + bw + sample:bw, import_data)   #actually bw cannot be used here, the factors should not be continued number. Linear model can solved this issue
summary(res_twoway_aov)
TukeyHSD(res_twoway_aov, which = "bw") #as bw is continued number, so error here