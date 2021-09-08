

library('rio');
library('synthpop');
orig0 <- import("C:/Users/GABE/Desktop/R/hcvdat0.csv");
orig0cb <- codebook.syn(orig0);
sim0 <- syn(orig0);
compare(sim0,orig0);
export(sim0$syn,"data/sim_data.csv");






