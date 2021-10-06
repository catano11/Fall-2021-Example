#Intro to python on October 6, 2021
import pandas as pd  #load a python library
dat0 = pd.read_csv("data/sim_data.csv")
dat0
dat0.info()  
dat0.head()
dat0.describe()

dat0.sort_values('ALB')
dat0.sort_values(['ALB', 'CREA'])
dat0.sort_values(['ALB', 'CREA'],ascending = [False,True])
dat0.ALB  #subset
dat0['ALB']
dat0[['Age','ALB','CREA']]
dat0.ALB > 50
dat0[dat0.ALB > 50]
dat0.ALB.between(40, 50, inclusive=True) 
 
dat0.loc[dat0.ALB.between(40, 50, inclusive=True), 'CHOL' ]
dat0.iloc[10:30,2:5]
dat0['Ag e'] = 42
dat0.head()
dat0.eval('Age+PROT')
