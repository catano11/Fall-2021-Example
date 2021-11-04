#' ---
#' title: "Automating Repetitive Tasks"
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
library(broom);
#' Here are the libraries R currently sees:
search() %>% pander();
#' Load data
inputdata <- c(dat0 = "data/sim_data.csv"); # change to the actual path to your data
if(file.exists('local.config.R')) source ('local.config.R', local=TRUE, echo=FALSE);

dat0 <- import(inputdata['dat0']);
search()%>% pander();
# Load data
dat0 <- import(inputdata['dat0'])

#Create testing and training data

dat0$sample <- sample(c('train', 'test'), nrow(dat0), rep=T, prob= c(0.6667, 0.333));
dtrain <- subset(dat0, sample=='train');
dtest <- subset(dat0, sample=='test');
View(dtrain)


outcomes<- c("ALB", "PROT", "Age")
nonanalytical <- c("sample")
model1 <- lm(Age~PROT + ALB, dtrain)
summary(model1)

plot (model1)
prediction<- predict(model1)
plot(prediction,dtrain$Age)

setdiff(colnames(dtrain), c(outcomes, "sample"))
rightside <- setdiff(colnames(dtrain), c(outcomes, nonanalytical))
model2<-lm(paste(rightside, collapse = "+" ) %>% paste("Age~", .), dtrain)
summary(model2)

for (ii in outcomes) {
  model2 <- lm(paste(rightside, collapse = "+" ) %>% 
               paste(ii, "~", .), dtrain) %>% update(. ~.)
  
  print(model2)
  plot(model2, which = c(1:2), ask = FALSE)
}

#methods(plot)
#?plt.lm

# apply functions
results <- sapply(outcomes, function(ii) paste(rightside, collapse = "+") %>%
                            paste(ii, "~", .) %>% lm(dtrain) %>% update(. ~.),
                  simplify = FALSE)
                  
sapply(results,plot, which = c(1:2), ask = FALSE)
                  
sapply(results, tidy)
lapply(results, tidy) %>% bind_rows(.id = "model") ->results_df
results_df %>% pander()

res2 <- list() # create an empty list
reduced <- list()  # for the reduced models

for (ii in outcomes) {
  res2[[ii]] <-lm(paste(rightside, collapse = "+" ) %>% 
               paste(ii, "~", .), dtrain) %>% update(. ~.)
  ###reduced[[ii]] <- step(res2[[ii]], scope= list(lower=.~1, upper= .~(.)^2))
  
  ##Error in step(model2, scope = list(lower = . ~ 1, upper = . ~ .)) : 
  ##number of rows in use has changed: remove missing values?
  print(res2[[ii]])
  plot(res2[[ii]], which = c(1:2), ask=FALSE)
  plot(reduced[[ii]], which = (1:2), ask = FALSE)
  par(mfcol = c(1,2))
  plot(predict(res2[[ii]]), dtrain[[ii]])
  plot(predict(reduced[[ii]]), dtrain[[ii]])
  plot(predict(res2[[ii]], dtest), dtest[[ii]], main= paste("Original model", ii))
  plot(predict(reduced[[ii]], dtest), dtest[[ii]], main= paste("Stepwise",ii))
}


temp <- step(model2, scope= list(lower=.~1, upper= .~.))
plot(dtrain$Age, predict(temp))
plot(dtrain$Age, predict(model2))




#' Make a scatterplot matrix
ggpairs(dat0);
#' Set all the two-value columns to be TRUE/FALSE
dat1 <- mutate(dat0
               , across(where( function(xx) length(unique(xx))==2), factor) 
               , group =  sample(c('test', 'train'), size = n(), replace=TRUE ));
head(dat1$group)
dat1$group %>% table
dat1train <- subset(dat1, subset = group=='train') #creates a subset for train
dat1test <- subset(dat1, subset = group=='test')   #creates a subset for test
