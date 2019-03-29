---
title: "first_markdown"
author: "Qiushuo Feng"
date: "16 January, 2019"
output:
  html_document:
    keep_md: true
---



## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


```r
summary(cars)
```

```
##      speed           dist       
##  Min.   : 4.0   Min.   :  2.00  
##  1st Qu.:12.0   1st Qu.: 26.00  
##  Median :15.0   Median : 36.00  
##  Mean   :15.4   Mean   : 42.98  
##  3rd Qu.:19.0   3rd Qu.: 56.00  
##  Max.   :25.0   Max.   :120.00
```

## Including Plots

You can also embed plots, for example:

![](first_markdown_files/figure-html/pressure-1.png)<!-- -->

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.

# Header 1
## Header 2
### Header 3
#### Header 4

* Fruits
    * apples
    * bananas
    * grapes
* Vegetables
    * carrots
    * brocoli

scary

1. ocelots
1. bears
1. tigers

Not scary

1. elephants
2. monkeys
3. rabbits

[This is a link to GitHub](https://github.com/)

![This is an image of a puppy](http://cdn2-www.dogtime.com/assets/uploads/gallery/30-impossibly-cute-puppies/impossibly-cute-puppy-8.jpg)

*italics* and _italics_ 

**bold** and __bold__

superscript^2^

~~strikethrough~~ 

[link](www.rstudio.com) 

endash: --  

emdash: ---   

inline equation: $A = \pi*r^{2}$ 

***

> block quote

* unordered list 
* item 2 
    + sub-item 1 
    + sub-item 2 
1. ordered list 
2. item 2 
    + sub-item 1 
    + sub-item 2 
Table Header  | Second Header 
------------- | ------------- 
Table Cell    | Cell 2        
Cell 3        | Cell 4        

Two plus two 
equals 4.

Here’s some code 

```r
dim(iris) 
```

```
## [1] 150   5
```

Here’s some code 

```r
dim(iris)
```


Here’s some code 

```
## [1] 150   5
```
