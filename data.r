#+ init, echo=FALSE, message=FALSE, warning=FALSE,results='hide'

debug <- 0;
knitr::opts_chunk$set(echo=debug>0, warning=debug>0, message=debug>0);
#' Load libraries
library(GGally);
library(rio);
library(dplyr);
library(pander);
library(synthpop);
#' Here are the libraries R currently sees:
search() %>% pander();
#' Load data
inputdata <- c(dat0= "data/sim_data.csv"); # change to the actual path to your data
if(file.exists('local.config.R')) source ('local.config.R', local=TRUE, echo=FALSE);

dat0 <- import(inputdata['dat0']);



#' Make a scatterplot matrix
#' ggpairs(dat0);
#' Set all the two-value columns to be TRUE/FALSE
dat1 <- mutate(dat0
               , across(where( function(xx) length(unique(xx))==2), factor));
#' Now try the scatterplot matrix again
#' ggpairs(dat1);




inputdata <- c(dat0='data/sim_veteran.xlsx'); # change to the actual path to your data
dat0 <- import(inputdata['dat0']);


