#' ---
#' title: "[TRIPOD 1] Identify the study as developing and/or validating a multivariable prediction model, the target population, and the outcome to be predicted."
#' author: 'Author One ^1,✉^, Author Two ^1^'
#' abstract: |
#'  | [TRIPOD 2] Provide a summary of objectives, study design, setting, participants, sample size, predictors, outcome, statistical analysis, results, and conclusions.
#' documentclass: article
#' description: 'Manuscript'
#' clean: false
#' self_contained: true
#' number_sections: false
#' keep_md: true
#' fig_caption: true
#' css: production.css
#' output:
#'   html_document:
#'    code_folding: hide
#'    toc: true
#'    toc_float: true
#' ---


#+ init, echo=FALSE, message=FALSE, warning=FALSE,results='hide'

debug <- 0;
knitr::opts_chunk$set(echo=debug>0, warning=debug>0, message=debug>0);
#' Load libraries
library(GGally);
library(rio);
library(dplyr);
library(knitr)
library(pander);
library(synthpop);
#' Here are the libraries R currently sees:
search() %>% pander();
#' Load data
inputdata <- c(dat0 = "data/sim_data.csv"); # change to the actual path to your data
if(file.exists('local.config.R')) source ('local.config.R', local=TRUE, echo=FALSE);

dat0 <- import(inputdata['dat0']);
search()%>% pander();
# Load data
dat0 <- import(inputdata['dat0'])
#' Make a scatterplot matrix
ggpairs(dat0);
#' Set all the two-value columns to be TRUE/FALSE
dat1 <- mutate(dat0
               , across(where( function(xx) length(unique(xx))==2), factor));
#' Now try the scatterplot matrix again
ggpairs(dat1);



#' vignette('dplyr')
#' This will be interpreted as text
#'
#'Rows
#' #' filter
filter(dat0, Sex==" m   ")
#' Using pander to format a table
filter(dat0, Sex=="  m  ") %>% pander
#' pander with additional options
#' filter(dat0, sex==" m   ") %>% pander(split.tables=Inf,split.cells=Inf) or set to number for the column splitting

#' ## slice 
slice(dat0,1-15) # show rows 1-15
dat0[1:15,]
dat0 %>% slice(1:15) %>% pander(split.tables=Inf,split.cells=Inf) # show rows 1-15
dat0 %>% slice_head(n=15)%>% pander(split.tables=Inf,split.cells=Inf) # show top 15 rows of the data
dat0 %>% slice_head(prop=0.1)%>% pander(split.tables=Inf,split.cells=Inf) # show top 10% of the rows
slice_sample(dat0, n=5, replace=TRUE)

#' ## arrange
arrange(dat0, Age, Sex)%>% slice_head(n=15)%>% pander(split.tables=Inf,split.cells=Inf)

#' ## Summarize
#' 
#' Aggregates data
#summarize(dat0, mean)
#' Use Args to identify details of function for syntax
# args(summarize)
# ?summarize
summarize(dat0, mean=mean(stat))
summarize(dat0, across (.cols=everything(),mean))
dat0 %>% summarize(across (.cols=everything(),mean))

#2^dat0$log2FoldChange %>% round() %>% head  #exponential base 2 and rounding
#2^dat0$log2FoldChange %>% round() %>% hist(breaks=1000, xlim=c(0,20))
#2^dat0$log2FoldChange %>% round() %>%  pmin(10) %>% table
#dat0$FoldChange <- 2^dat0$log2FoldChange %>% round() %>%  pmin(10)
#group_by(dat0, FoldChange) %>% summarize(across (.cols=everything(),mean))
#group_by(dat0, FoldChange) %>% summarize(across (.cols=everything(),list(mean=mean, sd=sd)))
 
#'# ggplot2 
#'
ggplot(dat0, aes(y=PROT))+ geom_bar()  
ggplot(dat0, aes(x=ALB))+ geom_bar()  #histogram plotting
ggplot (dat0, aes(x=ALB, y=PROT)) + geom_point()
ggplot (dat0, aes(x=ALB, y=PROT, color= Sex)) + geom_point()
ggplot (dat0, aes(x=ALB, y=PROT, color= Sex)) + geom_line()

#' grouping-1
ggplot (dat0, aes(x=ALB, y=PROT, color= Sex, group=Age)) + geom_line()
ggplot (dat0, aes(x=ALB, y=PROT, color= Sex, group=Age)) + geom_line(aes(group=Sex)) + geom_point()
ggplot (dat0, aes(x=ALB, y=PROT, color= Sex, group=Age)) + geom_line(aes(group=Sex)) + geom_point(aes(group=Category))
ggplot (dat0, aes(x=ALB, y=PROT)) + geom_line(aes(group=Sex)) + geom_point(aes(color=Category))

ggplot (dat0, aes(x=ALB, y=PROT)) + geom_line(aes(group=Sex)) + geom_point(aes(group=Sex,color=Age))
ggplot (dat0, aes(x=ALB, y=PROT)) + geom_line(aes(group=Sex)) + geom_point(aes(group=Sex,color=Age))+ 
  facet_grid( Sex ~ .)
ggplot (dat0, aes(x=ALB, y=PROT)) + geom_line(aes(group=Sex)) + geom_point(aes(group=Sex,color=Age))+ 
  facet_grid( . ~ Sex) 
ggplot (dat0, aes(x=ALB, y=PROT)) + geom_line(aes(group=Sex)) + geom_point(aes(group=Sex,color=Age))+ 
  facet_grid( Category ~ Sex) 



ggplot (dat0, aes(x=ALB, y=PROT, color= Sex, group=Age)) + geom_line() + geom_point()
ggplot (dat0, aes(x=ALB, y=PROT, color= Sex, group=Age)) + 
  geom_line(aes(group=Sex)) + 
  geom_point(aes(y=Age))+
  geom_point(aes(color=Category))

ggplot (dat0, aes(x=ALB, y=PROT, color= Sex, group=Age)) + 
  geom_line(aes(group=Sex)) + 
  geom_line(aes(y=Age), color="red")+
  geom_point(aes(color=Category))

ggplot (dat0, aes(x=ALB, y=PROT, color= Sex, group=Age)) + 
  geom_line(aes(group=Sex)) + 
  geom_line(aes(y=Age), alpha=0.5)+
  geom_point(aes(color=Category))

ggplot (dat0, aes(x=ALB, y=PROT)) + geom_smooth(method="lm") + geom_point()
ggplot (dat0, aes(x=ALB, y=PROT)) + geom_smooth(method="glm") + geom_point()
ggplot (dat0, aes(x=ALB, y=PROT)) + geom_smooth()+ geom_smooth(method="lm") + geom_point()
ggplot (dat0, aes(x=ALB, y=PROT)) + geom_smooth(color="red")+ geom_smooth(method="lm", color="blue") + geom_point(aes(color=Sex))
ggplot (dat0, aes(x=ALB, y=PROT)) + geom_smooth(fill="pink", color="red")+ geom_smooth(method="lm", fill="light blue", color="blue") + geom_point(aes(color=Sex))

#' plot from two dataset
layers <- list (geom_smooth(fill="pink", color="red"), geom_smooth(method="lm", fill="light blue", color="blue"), geom_point(aes(color=Sex)))    
ggplot(dat0, aes(x=ALB, y=PROT))  + layers             
ggplot(dat1, aes(x=ALB, y=PROT))  + layers 

#' To exclude the second item from a list:
foo <- list(a=1, b=2:10, c=runif(5))
foo[-2]

#'to change one layer
ggplot (dat0, aes(x=ALB,y=PROT)) + layers[-2]
ggplot (dat0, aes(x=ALB,y=PROT)) + layers[c(1,3)]


#+ggpairs, cache=TRUE

ggplot (dat0, aes(x=ALB,y=PROT)) + layers[-2] + geom_smooth(method="lm", fill="lightblue", color="green")




