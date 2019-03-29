#! /usr/bin/env Rscript
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

#perform linear regression model
res_lm <- lm(linalool ~sample+bw, import_data)
summary(res_lm)
#test the overall association between linalool and sample, controlling for bw.
anova(lm(linalool ~bw, import_data), res_lm)


#perform linear regression model include interaction between sample and bw
res_lm <- lm(linalool ~sample * bw, import_data)   #this is the same as lm(linalool ~sample+bw+sample:bw, import_data)
summary(res_lm)
#test the overall associationbetween linalool and sample, this time include interaction
jFit <- lm(linalool ~sample*bw, import_data)
anova(lm(linalool ~bw, import_data), jFit)
